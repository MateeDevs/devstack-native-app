//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer
import RxCocoa
import RxSwift
import UIKit

public class FlowController: NSObject {
    
    let navigationController: UINavigationController
    let dependencies: UseCaseDependency
    
    private weak var parentController: FlowController?
    private(set) var childControllers: [FlowController] = []
    
    private(set) var rootViewController: UIViewController?
    
    public init(navigationController: UINavigationController, dependencies: UseCaseDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        Logger.info("%@ initialized", "\(type(of: self))", category: .lifecycle)
    }
    
    deinit {
        Logger.info("%@ deinitialized", "\(type(of: self))", category: .lifecycle)
    }
    
    /// Override this method in a subclass and return initial ViewController of the flow.
    func setup() -> UIViewController {
        UIViewController()
    }
    
    /// Override this method in a subclass and setup handlings for all required flows.
    func handleFlow(_ flow: Flow) {}
    
    /// Default implementation for dismissing a modal flow. Override in a subclass if you want a custom behavior.
    func dismiss() {
        navigationController.dismiss(animated: true, completion: { [weak self] in
            self?.stopFlow()
        })
    }
    
    /// Starts child flow controller and returns initial ViewController.
    func startChildFlow(_ flowController: FlowController) -> UIViewController {
        childControllers.append(flowController)
        flowController.parentController = self
        flowController.navigationController.delegate = flowController
        flowController.rootViewController = flowController.setup()
        return flowController.rootViewController ?? UIViewController()
    }
    
    /// Stops flow controller. Must be called when returning to a parent flow controller.
    func stopFlow() {
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

extension Reactive where Base: FlowController {
    /// Bindable sink for `handleFlow` method
    var handleFlow: Binder<Flow> {
        Binder(self.base) { base, flow in
            base.handleFlow(flow)
        }
    }
}
