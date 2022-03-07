//
//  Created by Petr Chmelar on 27/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

@IBDesignable class BaseTableViewCell: UITableViewCell {

    // MARK: UI components
    private var separator = UIView()

    // MARK: Stored properties
    static let estimatedHeight: CGFloat = 44.0
    
    @IBInspectable var showDefaultSeparator: Bool = true {
        didSet {
            separator.isHidden = showDefaultSeparator
        }
    }
    
    @IBInspectable var separatorColor: UIColor = AppTheme.Colors.separator {
        didSet {
            separator.backgroundColor = separatorColor
        }
    }

    // MARK: Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        addSeparator()
    }

    // MARK: Additional methods
    private func addSeparator() {
        contentView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}
