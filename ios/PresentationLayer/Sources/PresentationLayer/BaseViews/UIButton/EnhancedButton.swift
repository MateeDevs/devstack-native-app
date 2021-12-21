//
//  Created by Viktor Kaderabek on 30/07/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

@IBDesignable class EnhancedButton: LocalizedButton {

    // MARK: UI components

    // MARK: Stored properties
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = AppTheme.Colors.primaryColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    
    @IBInspectable var titleRightPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.right = titleRightPadding
        }
    }
    
    @IBInspectable var titleTopPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.top = titleTopPadding
        }
    }
    
    @IBInspectable var titleBottomPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
    
    @IBInspectable var imageLeftPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.left = imageLeftPadding
        }
    }
    
    @IBInspectable var imageRightPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.right = imageRightPadding
        }
    }
    
    @IBInspectable var imageTopPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.top = imageTopPadding
        }
    }
    
    @IBInspectable var imageBottomPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.bottom = imageBottomPadding
        }
    }
    
    @IBInspectable var imageColor: UIColor = AppTheme.Colors.primaryColor {
        didSet {
            if currentImage != nil {
                setImage(currentImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
                tintColor = imageColor
            } else {
                setImage(nil, for: .normal)
            }
        }
    }
    
    @IBInspectable var enableImageRightAligned: Bool = false
    
    @IBInspectable var enableGradientBackground: Bool = false
    @IBInspectable var enableGradientStyleHorizontal: Bool = false
    
    @IBInspectable var gradientColor1: UIColor = .systemRed
    @IBInspectable var gradientColor2: UIColor = .systemBlue
    @IBInspectable var gradientColorDisabled1: UIColor = .systemRed
    @IBInspectable var gradientColorDisabled2: UIColor = .systemBlue

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
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if enableImageRightAligned, let imageView = imageView {
            imageEdgeInsets.left = bounds.width - imageView.bounds.width - imageRightPadding
        }
        
        if enableGradientBackground {
            setupGradient()
        }
    }

    // MARK: Additional methods
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        if isEnabled {
            gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
        } else {
            gradientLayer.colors = [gradientColorDisabled1.cgColor, gradientColorDisabled2.cgColor]
        }
        
        if enableGradientStyleHorizontal {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        }
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
