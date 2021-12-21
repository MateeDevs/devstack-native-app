//
//  Created by Viktor Kaderabek on 22/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {

    // MARK: UI components

    // MARK: Stored properties
    @IBInspectable var color1: UIColor = .systemRed
    @IBInspectable var color2: UIColor = .systemBlue
    
    @IBInspectable var location1: CGFloat = 0.0
    @IBInspectable var location2: CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    // MARK: Inits
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Default methods
    private func setup() {
        applyGradientLayer()
    }

    // MARK: Additional methods
    private func applyGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [location1, location2] as [NSNumber]
        layer.addSublayer(gradientLayer)
    }
}
