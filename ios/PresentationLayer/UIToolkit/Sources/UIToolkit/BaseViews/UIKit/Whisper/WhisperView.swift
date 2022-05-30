//
//  Created by Petr Chmelar on 19/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

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
        messageLabel.textColor = UIColor(AppTheme.Colors.whisperMessage)
        messageLabel.font = AppTheme.Fonts.whisperMessageUIKit

        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
}