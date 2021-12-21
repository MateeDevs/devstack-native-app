//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import UIKit

@IBDesignable class StateButton: UIButton {

    // MARK: UI components

    // MARK: Stored properties
    @IBInspectable var isOn: Bool = false

    @IBInspectable var titleOnState: String? {
        didSet {
            updateTitle()
        }
    }

    @IBInspectable var titleOffState: String? {
        didSet {
            updateTitle()
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
        addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
    }
    
    @objc func didTouchUpInside(_ button: UIButton) {
        isOn = !isOn
        updateTitle()
    }

    // MARK: Additional methods
    private func updateTitle() {
        let titleForState = (isOn ? titleOnState : titleOffState) ?? title(for: .normal) ?? ""
        setTitle(NSLocalizedString(titleForState, bundle: .module, comment: ""), for: .normal)
    }
}
