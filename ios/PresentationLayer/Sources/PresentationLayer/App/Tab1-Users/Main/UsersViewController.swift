//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import RxSwift
import UIKit

extension Flow {
    enum Users {
        case showUserDetailForId(_ userId: String)
    }
}

final class UsersViewController: BaseTableViewController<User> {
    
    // MARK: FlowController
    private weak var flowController: FlowController?

    // MARK: ViewModels
    private var viewModel: UsersViewModel?

    // MARK: UI components

    // MARK: Stored properties
    
    // MARK: Inits
    static func instantiate(fc: FlowController, vm: UsersViewModel) -> UsersViewController {
        let vc = StoryboardScene.Users.initialScene.instantiate()
        vc.flowController = fc
        vc.viewModel = vm
        return vc
    }

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells([UserTableViewCell.nameOfClass])
    }

    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        guard let viewModel = viewModel else { return }

        // Inputs
        page.bind(to: viewModel.input.page).disposed(by: disposeBag)

        // Outputs
        viewModel.output.users.drive(data).disposed(by: disposeBag)
        viewModel.output.loadedCount.drive(loadedCount).disposed(by: disposeBag)
        viewModel.output.isRefreshing.drive(isRefreshing).disposed(by: disposeBag)
    }

    override func setupUI() {
        super.setupUI()
        
		navigationItem.title = L10n.users_view_toolbar_title
    }

    // MARK: TableView methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserTableViewCell.nameOfClass,
            for: indexPath
        ) as? UserTableViewCell else { return UITableViewCell() }
        
        let user = items[indexPath.row]
        cell.setupWithUser(user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = items[indexPath.row]
        flowController?.handleFlow(.users(.showUserDetailForId(user.id)))
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UserTableViewCell.estimatedHeight
    }

    // MARK: Additional methods
}
