//
//  Created by Petr Chmelar on 06/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import DomainLayer

@MainActor
public class BaseViewModel {
    
    let trackScreenAppear: () -> Void
    
    /// All tasks that are currently executed
    private var tasks: [Task<Void, Never>] = []

    init(trackScreenAppear: @escaping () -> Void = {}) {
        self.trackScreenAppear = trackScreenAppear
        Logger.info("%@ initialized", "\(type(of: self))", category: .lifecycle)
    }
    
    deinit {
        Logger.info("%@ deinitialized", "\(type(of: self))", category: .lifecycle)
    }
    
    /// Override this method in a subclass for custom behavior when a view appears
    public func onAppear() {}
    
    /// Override this method in a subclass for custom behavior when a view disappears
    public func onDisappear() {
        // Cancel all tasks when we are going away
        tasks.forEach { $0.cancel() }
    }
    
    func executeTask(_ task: Task<Void, Never>) -> Task<Void, Never> {
        tasks.append(task)
        return Task {
            await task.value
            tasks = tasks.filter { $0 != task } // Remove task when done
        }
    }
}
