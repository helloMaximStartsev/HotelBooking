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
    private let hotelInfoView = HotelInfoView()
    private let bookingInfoView = BookingInfoView()
    private let contactInfoView = ContactInfoView()
    private let paymentInfoView = PaymentInfoView()
    
    private lazy var tableView: TableViewAdjustedHeight = {
        let tableView = TableViewAdjustedHeight(frame: .zero, style: .grouped)
        tableView.register(InputTableViewCell.self, forCellReuseIdentifier: InputTableViewCell.identifier)
        tableView.register(CollapsibleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CollapsibleTableViewHeader.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 12
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
        Section(touristName: "Первый турист",
                fieldNames: ["Имя",
                             "Фамилия",
                             "Дата рождения",
                             "Гражданство",
                             "Номер загранпаспорта",
                             "Срок действия загранпаспорта"],
                isExpanded: false),
        Section(touristName: "Второй турист",
                fieldNames: ["Имя",
                             "Фамилия",
                             "Дата рождения",
                             "Гражданство",
                             "Номер загранпаспорта",
                             "Срок действия загранпаспорта"],
                isExpanded: false),
        Section(touristName: "Третий турист",
                fieldNames: ["Имя",
                             "Фамилия",
                             "Дата рождения",
                             "Гражданство",
                             "Номер загранпаспорта",
                             "Срок действия загранпаспорта"],
                isExpanded: false),
    ]
    
    // MARK: - Initialization
    
    init(viewModel: BookingInfoViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        bindBookingInfo()
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
    }
    
    deinit {
        print(#function, NSStringFromClass(BookingInfoViewController.self))
    }
}

// MARK: - Private functions

private extension BookingInfoViewController {
    
    func setupView() {
        title = "Бронирование"
        view.backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
    }
    
    func setupSubviews() {
        view.addSubview(scrollView)
        view.addSubview(payButton)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(hotelInfoView)
        contentView.addSubview(bookingInfoView)
        contentView.addSubview(contactInfoView)
        contentView.addSubview(tableView)
        contentView.addSubview(paymentInfoView)
    }
    
    func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(scrollView.contentLayoutGuide.snp.height)
                .inset(30)
        }
        hotelInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        bookingInfoView.snp.makeConstraints { make in
            make.top.equalTo(hotelInfoView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        contactInfoView.snp.makeConstraints { make in
            make.top.equalTo(bookingInfoView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(contactInfoView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        paymentInfoView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
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
    
    func bindBookingInfo() {
        viewModel.bookingInfo.bind { [unowned self] bookingInfo in
            guard let bookingInfo = bookingInfo else { return }
            DispatchQueue.main.async {
                self.hotelInfoView.setHotelInfo(bookingInfo)
                self.bookingInfoView.setBookingInfo(bookingInfo)
                self.paymentInfoView.setPaymentInfo(bookingInfo)
            }
        }
    }
    
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
        sections[section].fieldNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as? InputTableViewCell else {
            return UITableViewCell()
        }
        cell.setCellData(text: sections[indexPath.section].fieldNames[indexPath.row])
        return cell
    }
    
}

// MARK: - CollapsibleTableViewHeaderDelegate

extension BookingInfoViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        sections[section].isExpanded.toggle()
        tableView.beginUpdates()
        
        var indexPathArray = [IndexPath]()
        for row in 0..<sections[section].fieldNames.count {
            let indexPath = IndexPath(row: row, section: section)
            indexPathArray.append(indexPath)
        }
        tableView.reloadRows(at: indexPathArray, with: .automatic)
        tableView.endUpdates()
    }
    
}

// MARK: - UITableViewDelegate

extension BookingInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sections[indexPath.section].isExpanded ? UITableView.automaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CollapsibleTableViewHeader.identifier) as? CollapsibleTableViewHeader else {
            return UITableViewHeaderFooterView()
        }
        
        headerView.setup(header: sections[section].touristName, section: section, delegate: self)
        return headerView
    }
    
}
