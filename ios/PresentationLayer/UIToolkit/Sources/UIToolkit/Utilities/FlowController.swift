//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import OSLog
import UIKit
import Utilities

public protocol Flow {}

@MainActor
open class FlowController: NSObject {
    
    public let navigationController: UINavigationController
    
    private weak var parentController: FlowController?
    public private(set) var childControllers: [FlowController] = []
    
    public private(set) var rootViewController: UIViewController?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        Logger.lifecycle.info("\(type(of: self)) initialized")
    }
    
    deinit {
        Logger.lifecycle.info("\(type(of: self)) deinitialized")
    }
    
    /// Override this method in a subclass and return initial ViewController of the flow.
    open func setup() -> UIViewController {
        UIViewController()
    }
    
    /// Override this method in a subclass and setup handlings for all flow cases.
    open func handleFlow(_ flow: Flow) {}
    
    /// Default implementation for dismissing a modal flow. Override in a subclass if you want a custom behavior.
    open func dismiss() {
        navigationController.dismiss(animated: true, completion: { [weak self] in
            self?.stopFlow()
        })
    }
    
    /// Default for poping a current view controller. Override in a subclass if you want a custom behavior.
    open func pop() {
        navigationController.popViewController(animated: true)
    }
    
    /// Starts child flow controller and returns initial ViewController.
    public func startChildFlow(_ flowController: FlowController) -> UIViewController {
        childControllers.append(flowController)
        flowController.parentController = self
        flowController.navigationController.delegate = flowController
        flowController.rootViewController = flowController.setup()
        return flowController.rootViewController ?? UIViewController()
    }
    
    /// Stops flow controller. Must be called when returning to a parent flow controller.
    public func stopFlow() {
        parentController?.removeChild(self)
    }
    
    private func removeChild(_ flowController: FlowController) {
        if let index = childControllers.firstIndex(where: { $0 === flowController }) {
            childControllers.remove(at: index)
        }
    }
}

extension FlowController: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        // Stop a child flow controller when returning to a parent flow controller via back button
        // Idea taken from [Back Buttons and Coordinators](http://khanlou.com/2017/05/back-buttons-and-coordinators/)
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController),
            fromViewController == rootViewController else { return }
        stopFlow()
    }
}
