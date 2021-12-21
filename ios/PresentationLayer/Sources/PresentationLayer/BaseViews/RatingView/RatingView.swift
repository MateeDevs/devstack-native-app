//
//  Created by Viktor Kaderabek on 07/03/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

protocol RatingViewDelegate: AnyObject {
    func ratingHasChanged(value: Int)
}

@IBDesignable class RatingView: XIBView {

    // MARK: UI components
    @IBOutlet private weak var star1: ColoredImageView!
    @IBOutlet private weak var star2: ColoredImageView!
    @IBOutlet private weak var star3: ColoredImageView!
    @IBOutlet private weak var star4: ColoredImageView!
    @IBOutlet private weak var star5: ColoredImageView!

    @IBOutlet private weak var starEmpty1: ColoredImageView!
    @IBOutlet private weak var starEmpty2: ColoredImageView!
    @IBOutlet private weak var starEmpty3: ColoredImageView!
    @IBOutlet private weak var starEmpty4: ColoredImageView!
    @IBOutlet private weak var starEmpty5: ColoredImageView!

    // MARK: Stored properties
    @IBInspectable var minimumRequiredStar: Int = 1

    @IBInspectable var ratingValue: Int = 0 {
        didSet {
            ratingDelegate?.ratingHasChanged(value: ratingValue)
            showRating(value: CGFloat(ratingValue))
        }
    }

    @IBInspectable var starDefaultColor: UIColor = .systemYellow {
        didSet {
            paintStars()
        }
    }

    @IBInspectable var starEmptyColor: UIColor = UIColorCompatible.systemGray4 {
        didSet {
            paintEmptyStars()
        }
    }

    private var starArray: [ColoredImageView] = []
    private var starEmptyArray: [ColoredImageView] = []

    weak var ratingDelegate: RatingViewDelegate?

    // MARK: Inits

    // MARK: Default methods
    override func configureViews() {
        super.configureViews()
        starArray = [star1, star2, star3, star4, star5]
        starEmptyArray = [starEmpty1, starEmpty2, starEmpty3, starEmpty4, starEmpty5]
        paintStars()
        paintEmptyStars()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            convertTouchToRate(point: location)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            convertTouchToRate(point: location)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            convertTouchToRate(point: location)
        }
    }

    // MARK: Additional methods
    private func showRating(value: CGFloat) {
        resetStars()
        
        let valueRounded = Int(value)
        let remaining = value - CGFloat(valueRounded)
        var starFullyHidden = starArray.count - valueRounded
        
        if remaining > 0 {
            let star = starArray[starArray.count - starFullyHidden]
            star.frame = CGRect(
                x: star.frame.origin.x,
                y: star.frame.origin.y,
                width: star.frame.size.width * remaining,
                height: star.frame.size.height
            )
            starFullyHidden -= 1
        }
        
        for (index, star) in starArray.enumerated().reversed() where index >= starArray.count - starFullyHidden {
            star.isHidden = true
        }
    }
    
    private func resetStars() {
        for star in starArray {
            star.isHidden = false
            if let defaultBounds = star.superview?.bounds {
                star.frame = defaultBounds
            }
        }
    }
    
    private func paintStars() {
        starArray.forEach { imageView in
            imageView.imageColor = starDefaultColor
        }
    }
    
    private func paintEmptyStars() {
        starEmptyArray.forEach { imageView in
            imageView.imageColor = starEmptyColor
        }
    }

    private func convertTouchToRate(point: CGPoint) {
        guard point.x > 0 else { return }
        
        let starWidth = frame.size.width / CGFloat(starArray.count)
        let ratingFloat = point.x / starWidth
        let ratingInt = Int(ratingFloat)
        
        if ratingFloat < 0.3 {
            if ratingValue != minimumRequiredStar {
                ratingValue = minimumRequiredStar
            }
        } else {
            if ratingValue != ratingInt + 1 {
                ratingValue = ratingInt + 1
            }
        }
    }
}
