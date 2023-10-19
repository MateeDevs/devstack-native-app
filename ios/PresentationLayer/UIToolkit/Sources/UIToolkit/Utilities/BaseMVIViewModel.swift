//
//  Created by David Kadlček on 03.04.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI
import Combine

@MainActor
public protocol MVIViewModel {
    // Lifecycle
    func onAppear()
    func onDisappear()
}

@MainActor
open class IntentViewModel<State: VmState, Intent: VmIntent>: ObservableObject, MVIViewModel {
    @Published open private(set) var state: State
    
    private var cancellables = Set<AnyCancellable>()

    public init(initialState: State) {
        state = initialState
    }
    
    public init() {
        state = .init()
    }
    
    private func reduceState(_ intent: Intent) -> AnyPublisher<State, Never> {
        Just(applyIntent(intent: intent))
            .eraseToAnyPublisher()
    }
    
    // Override this
    open func applyIntent(intent: Intent) -> State {
        State()
    }
    
    public func onIntent(intent: Intent) {
        Just(intent)
            .flatMap { [weak self] intent -> AnyPublisher<State, Never> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                return self.reduceState(intent)
                    .map { state in
                        self.state = state
                        return state
                    }
                    .eraseToAnyPublisher()
            }
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    // Override this
    open func onAppear() {
        
    }
    
    // Override this
    open func onDisappear() {
        
    }
}

public protocol VmState {
    init()
    
}

public protocol VmIntent {}
