//
//  Created by Petr Chmelar on 19/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

enum WhisperStyle {
    case info, success, error
    
    var color: UIColor {
        switch self {
        case .info: return AppTheme.Colors.alertBackgroundInfo
        case .success: return AppTheme.Colors.alertBackgroundSuccess
        case .error: return AppTheme.Colors.alertBackgroundError
        }
    }
}

class WhisperView: UIView {

    // MARK: UI components
    private let messageLabel = UILabel()

    // MARK: Stored properties
    var message: String = "" {
        didSet {
            messageLabel.text = message
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
        setupMessageLabel()
    }

    // MARK: Additional methods
    private func setupMessageLabel() {
        messageLabel.textAlignment = .center
        messageLabel.textColor = AppTheme.Colors.alertMessage
        messageLabel.font = AppTheme.Fonts.alertMessage

        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

}
