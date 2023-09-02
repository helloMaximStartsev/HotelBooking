//
//  RoomListViewController.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import UIKit
import SnapKit

final class RoomListViewController: UIViewController {
    
    private let viewModel: RoomListViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Initialization

    init(viewModel: RoomListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupLayout()
        configureNavigationBar()
        bindRoomList()
    }
    
    deinit {
        print(#function, NSStringFromClass(RoomListViewController.self))
    }

}

// MARK: - Private functions

private extension RoomListViewController {
    
    func setupView() {
        title = "Отель"
        view.backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "chevron-left")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(didTapBackButton)
        )
    }
    
    func bindRoomList() {
        viewModel.rooms.bind { [unowned self] _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc
    func didTapBackButton() {
        viewModel.didTapBackButton()
    }
}

// MARK: - UITableViewDataSource

extension RoomListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rooms = viewModel.rooms.value else { return 0 }
        
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rooms = viewModel.rooms.value,
              let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.identifier, for: indexPath) as? RoomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setCellData(room: rooms[indexPath.row])
        cell.delegate = self
        return cell
    }
    
}

// MARK: - RoomTableViewCellDelegate

extension RoomListViewController: RoomTableViewCellDelegate {
    
    func didTapChooseNumberButton() {
        viewModel.didTapChooseNumberButton()
    }

}
