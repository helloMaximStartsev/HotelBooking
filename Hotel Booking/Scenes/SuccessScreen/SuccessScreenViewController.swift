//
//  SuccessScreenViewController.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 31.08.2023.
//

import UIKit
import SnapKit

final class SuccessScreenViewController: UIViewController {
    
    private let viewModel: SuccessScreenViewModel
    private let successResult = UILabel.makeLabel(
        text: TextConstants.successResult,
        font: UIFont.boldSystemFont(ofSize: 22),
        textColor: .black,
        textAlignment: .center
    )
    private let successDescription = UILabel.makeLabel(
        text: TextConstants.successDescription,
        font: UIFont.systemFont(ofSize: 16),
        textColor: UIColor(hexString: ColorConstants.darkGrey),
        numberOfLines: 0,
        textAlignment: .center
    )
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.text = "🎉"
        return label
    }()
    private let greyCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
        view.layer.cornerRadius = 50
        return view
    }()
    private lazy var superButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: ColorConstants.darkBlue)
        button.layer.cornerRadius = 15
        button.setTitle("Cупер!", for: .normal)
        button.addTarget(self, action: #selector(didTapSuperButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization

    init(viewModel: SuccessScreenViewModel) {
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
    }
    
    deinit {
        print(#function, NSStringFromClass(SuccessScreenViewController.self))
    }

}

// MARK: - Private functions

private extension SuccessScreenViewController {
    
    func setupView() {
        title = "Заказ оплачен"
        view.backgroundColor = .white
    }
    
    func setupSubviews() {
        view.addSubview(successResult)
        view.addSubview(successDescription)
        view.addSubview(superButton)
        view.addSubview(greyCircle)
        view.addSubview(emojiLabel)
    }
    
    func setupLayout() {
        successResult.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.centerY.equalToSuperview()
        }
        emojiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(successResult.snp.top).offset(-50)
        }
        greyCircle.snp.makeConstraints { make in
            make.centerX.equalTo(emojiLabel.snp.centerX)
            make.centerY.equalTo(emojiLabel.snp.centerY)
            make.width.height.equalTo(100)
        }
        successDescription.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(successResult.snp.bottom).offset(20)
        }
        superButton.snp.makeConstraints { make in
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
    
    @objc
    func didTapSuperButton() {
        viewModel.didTapSuperButton()
    }
    
    @objc
    func didTapBackButton() {
        viewModel.didTapBackButton()
    }
    
}

private extension SuccessScreenViewController {
    
    enum TextConstants {
        static let successResult = "Ваш заказ принят в работу"
        static let successDescription = """
        Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.
        """
    }
    
}
