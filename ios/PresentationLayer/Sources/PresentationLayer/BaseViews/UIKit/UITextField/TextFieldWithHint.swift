//
//  Created by Petr Chmelar on 04/01/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import UIKit

enum TextFieldType {
    case text
    case number
    case email
    case phone
    case password
    case pin
}

@IBDesignable class TextFieldWithHint: UIControl {

    // MARK: UI components
    let textField = UITextField()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let textFieldView = UIView()
    private let hintLabel = UILabel()

    // MARK: Stored properties
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.text = NSLocalizedString(title, bundle: .module, comment: "")
            titleLabel.isHidden = title.isEmpty
        }
    }

    @IBInspectable var placeholder: String = "" {
        didSet {
            textField.placeholder = NSLocalizedString(placeholder, bundle: .module, comment: "")
        }
    }

    @IBInspectable var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
        }
    }

    @IBInspectable var hint: String = "" {
        didSet {
            hintLabel.text = NSLocalizedString(hint, bundle: .module, comment: "")
            hintLabel.isHidden = hint.isEmpty
        }
    }

    var type: TextFieldType = .text {
        didSet {
            setupType()
        }
    }

    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        alpha = isUserInteractionEnabled ? 1.0 : 0.5

        setupStackView()
        setupTitleLabel()
        setupTextFieldView()
        setupTextField()
        setupHintLabel()
    }

    // MARK: Additional methods
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 8

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setupTitleLabel() {
        titleLabel.textColor = AppTheme.Colors.textFieldTitle
        titleLabel.font = AppTheme.Fonts.textFieldTitle
        titleLabel.numberOfLines = 0
        titleLabel.isHidden = true
        stackView.addArrangedSubview(titleLabel)
    }

    private func setupTextFieldView() {
        textFieldView.layer.borderWidth = 2.0
        textFieldView.layer.borderColor = AppTheme.Colors.textFieldBorder.cgColor
        textFieldView.layer.cornerRadius = 8
        textFieldView.clipsToBounds = true
        stackView.addArrangedSubview(textFieldView)
    }

    private func setupTextField() {
        textField.font = AppTheme.Fonts.textFieldText
        textField.borderStyle = .none
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.textContentType = UITextContentType(rawValue: "")
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = false

        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        textFieldView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -16).isActive = true
        textField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 12).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -12).isActive = true
    }

    private func setupHintLabel() {
        hintLabel.font = AppTheme.Fonts.textFieldHint
        hintLabel.numberOfLines = 0
        hintLabel.isHidden = true
        stackView.addArrangedSubview(hintLabel)
    }

    private func setupType() {
        switch type {
        case .text:
            textField.keyboardType = .asciiCapable
        case .number:
            textField.keyboardType = .numberPad
            textField.addDoneButtonOnKeyboard()
        case .email:
            textField.keyboardType = .emailAddress
        case .phone:
            textField.keyboardType = .numberPad
            textField.addDoneButtonOnKeyboard()
            textField.clearButtonMode = .never
        case .password:
            textField.isSecureTextEntry = true
        case .pin:
            textField.keyboardType = .numberPad
            textField.addDoneButtonOnKeyboard()
            textField.isSecureTextEntry = true
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {}
}

extension TextFieldWithHint: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
