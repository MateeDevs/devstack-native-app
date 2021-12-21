//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class CounterDisplayViewController: BaseViewController {

    // MARK: FlowDelegate
    private weak var flowController: FlowController?

    // MARK: ViewModels
    private var displayViewModel: CounterDisplayViewModel?
    private var sharedViewModel: CounterSharedViewModel?

    // MARK: UI components
    @IBOutlet private weak var counterLabel: UILabel!

    // MARK: Stored properties

    // MARK: Inits
    static func instantiate(
        fc: FlowController,
        displayVM: CounterDisplayViewModel,
        sharedVM: CounterSharedViewModel
    ) -> CounterDisplayViewController {
        let vc = StoryboardScene.CounterDisplay.initialScene.instantiate()
        vc.flowController = fc
        vc.displayViewModel = displayVM
        vc.sharedViewModel = sharedVM
        return vc
    }

    // MARK: Lifecycle methods

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        guard let displayViewModel = displayViewModel, let sharedViewModel = sharedViewModel else { return }

        // Inputs

        // Outputs
        displayViewModel.output.counterValue.drive(counterLabel.rx.text).disposed(by: disposeBag)
        sharedViewModel.output.isCounterHidden.drive(counterLabel.rx.isHidden).disposed(by: disposeBag)
    }

    // MARK: Additional methods

}
