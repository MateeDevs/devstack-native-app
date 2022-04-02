//
//  Created by Viktor Kaderabek on 22/06/2017.
//  Copyright © 2017 Matee. All rights reserved.
//

import DomainLayer
import OSLog
import RxSwift
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Stored properties
    private(set) var disposeBag = DisposeBag()
    var trackScreenAppear: (() -> Void)?
    
    // MARK: Inits
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        Logger.lifecycle.info("\(type(of: self)) initialized")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger.lifecycle.info("\(type(of: self)) initialized")
    }
    
    deinit {
        Logger.lifecycle.info("\(type(of: self)) deinitialized")
    }
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Track that screen appears if required
        if let trackScreenAppear = trackScreenAppear {
            trackScreenAppear()
        }
        
        // As long as viewWillAppear make sure to setup your reactive bindings
        setupBindings()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Remove the current reference to the disposeBag so all current subscriptions are disposed
        disposeBag = DisposeBag()
        
        // Ensure that any presented WhisperView is removed
        hideWhisper()
    }
    
    // MARK: Default methods
    
    /// Override this method in a subclass and setup the reactive bindings
    func setupBindings() {
        // Fresh initializaton of DisposeBag whenever subscriptions are about to initialize
        disposeBag = DisposeBag()
    }
    
    /// Override this method in a subclass and setup the view appearance
    func setupUI() {
        // Setup background color and back button title
        view.backgroundColor = AppTheme.Colors.background
        navigationItem.backBarButtonItem = UIBarButtonItem(title: L10n.back, style: .plain, target: nil, action: nil)
    }
}
