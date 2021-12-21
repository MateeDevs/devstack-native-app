//
//  Created by Petr Chmelar on 20/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import UIKit

final class SettingsViewController: BaseViewController {

    // MARK: FlowDelegate
    private weak var flowController: FlowController?

    // MARK: ViewModels
    private var viewModel: SettingsViewModel?

    // MARK: UI components
    @IBOutlet private weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var smallButton: UIButton!
    @IBOutlet private weak var largeButton: UIButton!
    
    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(fc: FlowController, vm: SettingsViewModel) -> SettingsViewController {
        let vc = StoryboardScene.Settings.initialScene.instantiate()
        vc.flowController = fc
        vc.viewModel = vm
        return vc
    }

    // MARK: Lifecycle methods

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        guard let viewModel = viewModel else { return }
        
        // Inputs
        smallButton.rx.tap.bind(to: viewModel.input.smallButtonTaps).disposed(by: disposeBag)
        largeButton.rx.tap.bind(to: viewModel.input.largeButtonTaps).disposed(by: disposeBag)

        // Outputs
        viewModel.output.topViewHeight.drive(topViewHeightConstraint.rx.constant).disposed(by: disposeBag)
    }

    // MARK: Additional methods

}
