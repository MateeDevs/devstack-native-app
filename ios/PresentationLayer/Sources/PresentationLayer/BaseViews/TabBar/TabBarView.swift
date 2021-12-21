//
//  Created by Viktor Kaderabek on 04/08/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import UIKit

protocol TabBarViewDelegate: AnyObject {
    func didSelectViewController(tag: Int)
}

@IBDesignable class TabBarView: XIBView {

    // MARK: UI components
    @IBOutlet private weak var stripView: UIView! {
        didSet {
            stripView.backgroundColor = stripViewColor
        }
    }

    @IBOutlet private weak var stripViewHeightConstraint: NSLayoutConstraint! {
        didSet {
            stripViewHeightConstraint.constant = stripViewHeight
        }
    }

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var buttonsStackView: UIStackView!
    @IBOutlet private weak var leadingConstraintStripView: NSLayoutConstraint!
    @IBOutlet private weak var widthConstraintStripView: NSLayoutConstraint!

    // MARK: Stored properties
    @IBInspectable var shouldShowNumbers: Bool = false

    var buttonMainLabelFont: UIFont = UIFont.systemFont(ofSize: 16)
    var buttonMainLabelFontHighlighted: UIFont = UIFont.systemFont(ofSize: 16)

    @IBInspectable var buttonMainLabelColor: UIColor = AppTheme.Colors.label
    @IBInspectable var buttonMainLabelColorHighlighted: UIColor = AppTheme.Colors.label

    var buttonNumberLabelFont: UIFont = UIFont.systemFont(ofSize: 16)
    var buttonNumberLabelFontHighlighted: UIFont = UIFont.systemFont(ofSize: 16)

    @IBInspectable var buttonNumberLabelColor: UIColor = AppTheme.Colors.label
    @IBInspectable var buttonNumberLabelColorHighlighted: UIColor = AppTheme.Colors.label

    @IBInspectable var buttonNumberViewBackgroundColor: UIColor = .clear
    @IBInspectable var buttonNumberViewBackgroundColorHighlighted: UIColor = .clear

    @IBInspectable var buttonBackgroundColor: UIColor = .clear
    @IBInspectable var buttonBackgroundColorHighlighted: UIColor = .clear

    @IBInspectable var stripViewColor: UIColor = AppTheme.Colors.primaryColor {
        didSet {
            stripView?.backgroundColor = stripViewColor
        }
    }

    @IBInspectable var stripViewHeight: CGFloat = 4 {
        didSet {
            stripViewHeightConstraint?.constant = stripViewHeight
        }
    }

    weak var delegate: TabBarViewDelegate?

    private var tabBarButtons: [TabBarButton] = []

    var availableOptions: [String] = [] {
        didSet {
            addButtons(titles: availableOptions)
        }
    }

    // MARK: Inits

    // MARK: Default methods
    override func configureViews() {
        super.configureViews()
        widthConstraintStripView.constant = scrollView.contentSize.width / max(CGFloat(tabBarButtons.count), 1)
    }

    // MARK: Additional methods
    func select(_ index: Int, animated: Bool = false) {
        guard tabBarButtons.count > index else { return }
        selectViewController(tabBarButtons[index], animated: animated)
    }
    
    func updateNumbers(_ numbers: [Int]) {
        for index in 0...tabBarButtons.count - 1 where numbers.count > index {
            tabBarButtons[index].numberLabel.text = numbers[index] <= 999 ? "\(numbers[index])" : "999"
        }
        layoutIfNeeded()
        widthConstraintStripView.constant = scrollView.contentSize.width / max(CGFloat(tabBarButtons.count), 1)
    }
    
    private func addButtons(titles: [String]) {
        removeButtonsFromStackView()
        for (index, title) in titles.enumerated() {
            let btn = TabBarButton()
            btn.mainLabel.text = NSLocalizedString(title, bundle: .module, comment: "")
            btn.mainLabel.font = buttonMainLabelFont
            btn.mainLabel.textColor = buttonMainLabelColor
            btn.numberLabel.font = buttonNumberLabelFont
            btn.numberLabel.textColor = buttonNumberLabelColor
            btn.numberView.backgroundColor = buttonNumberViewBackgroundColor
            btn.view.backgroundColor = buttonBackgroundColor
            btn.numberView.isHidden = shouldShowNumbers ? false : true
            btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.btnSelected(_:))))
            btn.tag = index
            buttonsStackView.addArrangedSubview(btn)
            tabBarButtons.append(btn)
        }
    }
    
    private func removeButtonsFromStackView() {
        for view in buttonsStackView.arrangedSubviews {
            buttonsStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        tabBarButtons = []
    }
    
    @objc private func btnSelected(_ sender: UITapGestureRecognizer? = nil) {
        guard let btn = sender?.view as? TabBarButton, !btn.button.isSelected else { return }
        selectViewController(btn, animated: true)
    }
    
    private func selectViewController(_ sender: TabBarButton, animated: Bool) {
        for btn in tabBarButtons {
            if btn == sender {
                btn.button.isSelected = true
                btn.mainLabel.font = buttonMainLabelFontHighlighted
                btn.mainLabel.textColor = buttonMainLabelColorHighlighted
                btn.numberLabel.font = buttonNumberLabelFontHighlighted
                btn.numberLabel.textColor = buttonNumberLabelColorHighlighted
                btn.numberView.backgroundColor = buttonNumberViewBackgroundColorHighlighted
                btn.view.backgroundColor = buttonBackgroundColorHighlighted
                btn.numberView.isHidden = shouldShowNumbers ? false : true
                if !(UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft) {
                    leadingConstraintStripView.constant = btn.frame.origin.x
                } else {
                    leadingConstraintStripView.constant = scrollView.contentSize.width - btn.frame.origin.x - btn.frame.size.width
                }
                scrollToButton(btn)
            } else {
                btn.button.isSelected = false
                btn.mainLabel.font = buttonMainLabelFont
                btn.mainLabel.textColor = buttonMainLabelColor
                btn.numberLabel.font = buttonNumberLabelFont
                btn.numberLabel.textColor = buttonNumberLabelColor
                btn.numberView.backgroundColor = buttonNumberViewBackgroundColor
                btn.view.backgroundColor = buttonBackgroundColor
                btn.numberView.isHidden = shouldShowNumbers ? false : true
            }
        }
        
        if animated {
            UIView.animate(
                withDuration: 0.6,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0,
                options: .curveEaseIn,
                animations: { self.layoutIfNeeded() },
                completion: nil
            )
        }
        
        delegate?.didSelectViewController(tag: sender.tag)
    }
    
    private func scrollToButton(_ btn: TabBarButton) {
        var xOffset = btn.frame.origin.x + btn.frame.width / 2 - UIScreen.main.bounds.width / 2
        if xOffset < 0 {
            xOffset = 0
        } else if xOffset > scrollView.contentSize.width - view.bounds.width {
            xOffset = scrollView.contentSize.width - view.bounds.width
        }
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
}
