//
//  BookingInfoViewController.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit
import SnapKit

final class BookingInfoViewController: UIViewController {
    
    private let viewModel: BookingInfoViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView = UIView()
//    private let hotelInfoView = HotelInfoView()
    
    private lazy var tableView: TableViewAdjustedHeight = {
        let tableView = TableViewAdjustedHeight(frame: .zero, style: .grouped)
        tableView.register(InputTableViewCell.self, forCellReuseIdentifier: InputTableViewCell.identifier)
        tableView.register(CollapsibleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CollapsibleTableViewHeader.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.backgroundColor = .white
//        tableView.layer.borderColor = UIColor.red.cgColor
//        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 12
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: ColorConstants.darkBlue)
        button.layer.cornerRadius = 15
        button.setTitle("Оплатить", for: .normal)
        button.addTarget(self, action: #selector(didTapPayButton), for: .touchUpInside)
        return button
    }()
    
    var sections = [
        Section(courseName: "Первый турист",
                lessons: ["Имя",
                          "Фамилия",
                          "Дата рождения",
                          "Гражданство",
                          "Номер загранпаспорта",
                          "Срок действия загранпаспорта"],
                expanded: false),
//        Section(courseName: "Второй турист",
//                lessons: ["Имя",
//                          "Фамилия",
//                          "Дата рождения",
//                          "Гражданство",
//                          "Номер загранпаспорта",
//                          "Срок действия загранпаспорта"],
//                expanded: false),
//        Section(courseName: "Третий турист",
//                lessons: ["Имя",
//                          "Фамилия",
//                          "Дата рождения",
//                          "Гражданство",
//                          "Номер загранпаспорта",
//                          "Срок действия загранпаспорта"],
//                expanded: false),
    ]
    
    // MARK: - Initialization
    
    init(viewModel: BookingInfoViewModel) {
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
//        bindBookingInfo()
    }
    
    deinit {
        print(#function, NSStringFromClass(BookingInfoViewController.self))
    }
}

// MARK: - Private functions

private extension BookingInfoViewController {
    
    func setupView() {
        title = "Отель"
        view.backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
    }
    
    func setupSubviews() {
        view.addSubview(scrollView)
        view.addSubview(payButton)
        
        scrollView.addSubview(contentView)
        
//        contentView.addSubview(hotelInfoView)
        contentView.addSubview(tableView)
//        view.addSubview(tableView)
    }
    
    func setupLayout() {
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.leading.trailing.equalToSuperview()
//        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(scrollView.contentLayoutGuide.snp.height)
                .inset(50)
        }
//        hotelInfoView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.trailing.equalToSuperview()
//        }
        tableView.snp.makeConstraints { make in
//            make.top.equalTo(hotelInfoView.snp.bottom)
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        payButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
    
//    func bindBookingInfo() {
//        viewModel.bookingInfo.bind { [unowned self] bookingInfo in
//            guard let bookingInfo = bookingInfo else { return }
//            DispatchQueue.main.async {
//                self.hotelInfoView.setHotelInfo(bookingInfo)
//            }
//        }
//    }
    
    @objc
    func didTapPayButton() {
        viewModel.didTapPayButton()
    }
    
    @objc
    func didTapBackButton() {
        viewModel.didTapBackButton()
    }
}

// MARK: - UITableViewDataSource

extension BookingInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as? InputTableViewCell else {
            return UITableViewCell()
        }
        cell.setCellData(text: sections[indexPath.section].lessons[indexPath.row])
        return cell
    }
    

    
}

// MARK: - CollapsibleTableViewHeaderDelegate

extension BookingInfoViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        sections[section].expanded = !sections[section].expanded

        tableView.beginUpdates()
        for row in 0..<sections[section].lessons.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .bottom)
        }
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDelegate

extension BookingInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sections[indexPath.section].expanded ? UITableView.automaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CollapsibleTableViewHeader.identifier) as? CollapsibleTableViewHeader else {
            return UITableViewHeaderFooterView()
        }
        
        headerView.setup(header: sections[section].courseName, section: section, delegate: self)
        return headerView
    }
    
}
