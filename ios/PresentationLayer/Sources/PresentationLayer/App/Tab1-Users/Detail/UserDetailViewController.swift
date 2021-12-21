//
//  Created by Petr Chmelar on 28/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import RxSwift
import UIKit

final class UserDetailViewController: BaseViewController {

    // MARK: FlowController
    private weak var flowController: FlowController?

    // MARK: ViewModels
    private var viewModel: UserDetailViewModel?

    // MARK: UI components
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var userImageView: UserImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    // MARK: Stored properties
    
    // MARK: Inits
    static func instantiate(fc: FlowController, vm: UserDetailViewModel) -> UserDetailViewController {
        let vc = StoryboardScene.UserDetail.initialScene.instantiate()
        vc.flowController = fc
        vc.viewModel = vm
        vc.trackScreenAppear = vm.trackScreenAppear
        return vc
    }

    // MARK: Lifecycle methods

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        guard let viewModel = viewModel else { return }

        // Outputs
        viewModel.output.user.fullName.drive(userNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.output.user.initials.drive(userImageView.rx.initials).disposed(by: disposeBag)
        viewModel.output.user.imageURL.drive(userImageView.rx.imageURL).disposed(by: disposeBag)

        // Refresh
        if let refreshControl = scrollView.refreshControl {
            refreshControl.rx.controlEvent(.valueChanged).bind(to: viewModel.input.refreshTrigger).disposed(by: disposeBag)
            viewModel.output.isRefreshing.filter { !$0 }.drive(refreshControl.rx.isRefreshing).disposed(by: disposeBag)
        }
        viewModel.input.refreshTrigger.onNext(())
    }

    override func setupUI() {
        super.setupUI()
        
        scrollView.addRefreshControl()
        navigationItem.title = L10n.user_detail_view_toolbar_title
    }

    // MARK: Additional methods

}
