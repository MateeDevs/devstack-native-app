//
//  Created by Viktor Kaderabek on 12/09/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import AlamofireImage
import UIKit

@IBDesignable class UserImageView: XIBView {

    // MARK: UI components
    @IBOutlet private weak var initialsView: UIView! {
        didSet {
            initialsView.layer.borderWidth = 3
        }
    }
    @IBOutlet private weak var initialsLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    @IBInspectable var initialsTextColor: UIColor = .white {
        didSet {
            initialsLabel.textColor = initialsTextColor
            initialsView.layer.borderColor = initialsTextColor.cgColor
        }
    }

    @IBInspectable var initialsBackgroundColor: UIColor = AppTheme.Colors.primaryColor {
        didSet {
            initialsView.backgroundColor = initialsBackgroundColor
        }
    }

    // MARK: Stored properties
    @IBInspectable var initials: String? {
        didSet {
            setInitials()
        }
    }

    @IBInspectable var image: UIImage? {
        didSet {
            setImageOrPlaceholder()
        }
    }

    @IBInspectable var imageURL: String? {
        didSet {
            setImageOrPlaceholder()
        }
    }

    @IBInspectable var placeholder: UIImage? {
        didSet {
            setImageOrPlaceholder()
        }
    }

    // MARK: Inits

    // MARK: Default methods
    override func configureViews() {
        super.configureViews()

        layoutIfNeeded()
        setDimensions()
        backgroundColor = .clear

        view.isSkeletonable = true
        initialsView.isSkeletonable = true
    }

    // MARK: Additional methods
    private func setDimensions() {
        initialsView.layer.cornerRadius = initialsView.frame.size.width / 2.0
        initialsLabel.font = UIFont.systemFont(ofSize: initialsView.frame.size.width / 2.85, weight: .medium)
    }

    private func setInitials() {
        imageView.image = nil
        initialsLabel.text = initials
        initialsView.layer.borderWidth = 3
    }

    private func setImageOrPlaceholder() {
        if let imageURL = imageURL, let url = URL(string: imageURL) {
            imageView.af.setImage(withURL: url, placeholderImage: placeholder)
        } else {
            imageView.image = image != nil ? image : placeholder
        }
        initialsView.layer.borderWidth = 0
    }
}
