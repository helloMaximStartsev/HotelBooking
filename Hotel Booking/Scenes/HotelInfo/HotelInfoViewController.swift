//
//  HotelInfoViewController.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 30.08.2023.
//

import UIKit
import SnapKit

final class HotelInfoViewController: UIViewController {
    
    private let viewModel: HotelInfoViewModel

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView = UIView()
    private let mainHotelView = MainHotelView()
    private let hotelDescriptionView = HotelDescriptionView()
    private lazy var chooseNumbersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: ColorConstants.darkBlue)
        button.layer.cornerRadius = 15
        button.setTitle("К выбору номера", for: .normal)
        button.addTarget(self, action: #selector(didTapChooseNumbersButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization

    init(viewModel: HotelInfoViewModel) {
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
        bindHotelInfo()
    }
    
    deinit {
        print(#function, NSStringFromClass(HotelInfoViewController.self))
    }

}

// MARK: - Private functions

private extension HotelInfoViewController {

    func setupView() {
        title = "Отель"
        view.backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
    }
    
    func setupSubviews() {
        view.addSubview(scrollView)
        view.addSubview(chooseNumbersButton)

        scrollView.addSubview(contentView)
        
        contentView.addSubview(mainHotelView)
        contentView.addSubview(hotelDescriptionView)
        
        hotelDescriptionView.layer.borderColor = UIColor.red.cgColor
        hotelDescriptionView.layer.borderWidth = 3
    }
    
    func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.top.leading.trailing.width.equalToSuperview()
            make.height.equalTo(scrollView.contentLayoutGuide.snp.height).inset(200)
        }
        mainHotelView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        hotelDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(mainHotelView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        chooseNumbersButton.snp.makeConstraints { make in
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
    }
    
    func bindHotelInfo() {
        viewModel.hotelInfo.bind { [unowned self] hotelInfo in
            guard let hotelInfo = hotelInfo else { return }
            DispatchQueue.main.async {
                self.mainHotelView.setHotelInfo(hotelInfo)
                self.hotelDescriptionView.setHotelDescription(hotelInfo.aboutTheHotel)
            }
        }
    }
    
    @objc
    func didTapChooseNumbersButton() {
        viewModel.didTapChooseNumbersButton()
    }

}
