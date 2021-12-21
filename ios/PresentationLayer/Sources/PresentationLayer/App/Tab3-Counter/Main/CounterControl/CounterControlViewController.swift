//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class CounterControlViewController: BaseViewController {

    // MARK: FlowDelegate
    private weak var flowController: FlowController?

    // MARK: ViewModels
    private var controlViewModel: CounterControlViewModel?
    private var sharedViewModel: CounterSharedViewModel?

    // MARK: UI components
    @IBOutlet private weak var increaseButton: SecondaryButton!
    @IBOutlet private weak var decreaseButton: SecondaryButton!
    @IBOutlet private weak var hideButton: SecondaryButton!

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(
        fc: FlowController,
        controlVM: CounterControlViewModel,
        sharedVM: CounterSharedViewModel
    ) -> CounterControlViewController {
        let vc = StoryboardScene.CounterControl.initialScene.instantiate()
        vc.flowController = fc
        vc.controlViewModel = controlVM
        vc.sharedViewModel = sharedVM
        return vc
    }

    // MARK: Lifecycle methods

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        guard let controlViewModel = controlViewModel, let sharedViewModel = sharedViewModel else { return }

        // Inputs
        increaseButton.rx.tap.bind(to: controlViewModel.input.increaseButtonTaps).disposed(by: disposeBag)
        decreaseButton.rx.tap.bind(to: controlViewModel.input.decreaseButtonTaps).disposed(by: disposeBag)
        hideButton.rx.isOn.bind(to: sharedViewModel.input.hideButtonIsOn).disposed(by: disposeBag)

        // Outputs
        controlViewModel.output.increaseCounter.drive().disposed(by: disposeBag)
        controlViewModel.output.decreaseCounter.drive().disposed(by: disposeBag)
    }

    // MARK: Additional methods

}
