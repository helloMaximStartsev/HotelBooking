//
//  InputTableViewCellDelegate.swift
//  Hotel Booking
//
//  Created by Maxim Startsev on 01.09.2023.
//

import UIKit
import SnapKit

protocol InputTableViewCellDelegate: AnyObject {
    func setPhoneNumberValid(value: Bool)
    func setEmailValid(value: Bool)
    func setTuristFormValid(value: Bool)
}

final class InputTableViewCell: UITableViewCell {
    
    weak var delegate: InputTableViewCellDelegate?
    static let identifier = "InputTableViewCell"
    private var inputValue: String?
    
    // MARK: - UI
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: ColorConstants.lightGrey)
        view.layer.cornerRadius = 12
        return view
    }()
    private let label = UILabel.makeLabel(
        text: "label",
        font: UIFont.boldSystemFont(ofSize: 12),
        textColor: UIColor(hexString: ColorConstants.darkGrey)
    )
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [.strokeColor : UIColor(red: 169/255, green: 171/255, blue: 183/255, alpha: 1)])
        textField.textColor = .black
        textField.addTarget(self, action: #selector(didEndEditing(sender:)), for: .editingDidEnd)
        return textField
    }()
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupSubviews()
        setupLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions

    func setCellData(text: String) {
        label.text = text
        textField.placeholder = text
    }
    
    func displayErrorState() {
        containerView.layer.borderColor = UIColor.red.cgColor
        containerView.layer.borderWidth = 1
    }
    
    func displayNormalState() {
        containerView.layer.borderColor = UIColor.clear.cgColor
    }

    override func prepareForReuse() {
        label.text = ""
        textField.text = ""
        containerView.layer.borderColor = UIColor.clear.cgColor
    }
}

// MARK: - Private functions

private extension InputTableViewCell {
    
    func setupCell() {
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(label)
        containerView.addSubview(textField)
    }
    
    func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(16)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    @objc
    func didEndEditing(sender: UITextView) {
        guard !sender.text.isEmpty else {
            displayErrorState()
            return
        }
        
        isInputValid(input: sender.text) ? displayNormalState() : displayErrorState()
    }
    
    func isInputValid(input: String) -> Bool {
        switch label.text {
        case "Номер телефона":
            let result = input.count == 18
            delegate?.setPhoneNumberValid(value: result)
            return result
        case "Почта":
            let result = isValidEmail(input)
            delegate?.setEmailValid(value: result)
            return result
        default:
            return true
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(char)
            }
        }
        return result
    }
    
}

extension InputTableViewCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
              label.text == "Номер телефона" else { return true }
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XX-XX", phone: newString)
        return false
    }
    
}
