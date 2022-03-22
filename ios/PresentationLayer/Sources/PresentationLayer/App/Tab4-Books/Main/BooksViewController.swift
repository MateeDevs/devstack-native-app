//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import class DevstackKmpShared.Book
import RxSwift
import UIKit

final class BooksViewController: BaseTableViewController<Book> {
    
    // MARK: FlowController
    private weak var flowController: FlowController?
    
    // MARK: ViewModels
    private var viewModel: BooksViewModel?
    
    // MARK: UI components
    
    // MARK: Stored properties
    
    // MARK: Inits
    static func instantiate(fc: FlowController, vm: BooksViewModel) -> BooksViewController {
        let vc = StoryboardScene.Books.initialScene.instantiate()
        vc.flowController = fc
        vc.viewModel = vm
        return vc
    }
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells([BookTableViewCell.nameOfClass])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.start()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.stop()
    }
    
    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        guard let viewModel = viewModel else { return }
        
        // Inputs
        page.bind(to: viewModel.input.page).disposed(by: disposeBag)
        
        // Outputs
        viewModel.output.books.drive(data).disposed(by: disposeBag)
        viewModel.output.loadedCount.drive(loadedCount).disposed(by: disposeBag)
        viewModel.output.isRefreshing.drive(isRefreshing).disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        navigationItem.title = L10n.books_view_toolbar_title
    }
    
    // MARK: TableView methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BookTableViewCell.nameOfClass,
            for: indexPath
        ) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = items[indexPath.row]
        cell.setupWithBook(book)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        BookTableViewCell.estimatedHeight
    }
    
    // MARK: Additional methods
}
