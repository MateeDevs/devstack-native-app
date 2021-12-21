//
//  Created by Petr Chmelar on 09/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import RxSwift
import UIKit

class BaseTableViewController<T>: BaseViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UI components
    // swiftlint:disable:next private_outlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            // If you need separator add it directly into the cell
            tableView.separatorStyle = .none
        }
    }
    
    // MARK: Stored properties
    private(set) var items: [T] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private(set) var page = PublishSubject<Int>()
    private var shouldFetchMore = false
    private var currentPage: Int = 0
    private var perPage: Int = Constants.paginationCount
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentPage = 0
        page.onNext(currentPage)
    }
    
    // MARK: Default methods
    override func setupBindings() {
        super.setupBindings()
        
        tableView.refreshControl?.rx.controlEvent(.valueChanged).bind(onNext: { [weak self] in
            self?.page.onNext(0)
        }).disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        tableView.addRefreshControl()
    }
    
    // MARK: Additional methods
    func registerCells(_ identifiers: [String]) {
        for identifier in identifiers {
            let cellNib = UINib(nibName: identifier, bundle: .module)
            tableView?.register(cellNib, forCellReuseIdentifier: identifier)
        }
    }
    
    func setData(_ data: [T]) {
        self.items = data
    }
    
    func updatePaging(_ loadedCount: Int) {
        currentPage += 1
        shouldFetchMore = loadedCount == perPage ? true : false
    }
    
    // MARK: UIScrollViewDelegate methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isNearBottomEdge(), shouldFetchMore else { return }
        shouldFetchMore = false
        page.onNext(currentPage)
    }
    
    // MARK: UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Override this method in a subclass and setup the cells
        UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Override this method in a subclass and setup the action
    }
    
    // MARK: UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // Override this method in a subclass and set the estimated height
        BaseTableViewCell.estimatedHeight
    }
}
