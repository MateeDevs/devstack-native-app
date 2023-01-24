//
//  SnackState.swift
//
//
//  Created by Filip Wiesner on 15.01.2023.
//

import Combine
import Foundation
import SwiftUI
import Utilities

/// Visual information for a snackbar.
public protocol SnackVisuals: Equatable {
    var message: String { get }
    var actionLabel: String? { get }
    
    /// Duration in **seconds**
    var duration: Int { get }
}

/// Cause for a snackbar disappearance.
public enum SnackResult {
    case actionPerformed
    case dismissed
}

/// State holder that coordinates appearence of the snacbars. Contains currentData which is used for hooking up ``SnackHost``.
/// ``SnackVisuals`` protocol defines the visual aspect of the Snackbar. ``InfoErrorSnackVisuals`` are provided by default.
@MainActor
public class SnackState<Visuals: SnackVisuals>: ObservableObject {
    private let semaphore = AsyncSemaphore(value: 1)
    @Published public private(set) var currentData: SnackData<Visuals>?
    
    public init() {}
    
    /// Asynchronous function for displaying the snackbar. Suspends until the snackbar is either dismissed or action is selected.
    /// Only one snackbar can be visible at one time. If called asynchronously from different places, one caller will be suspended until the firs snack is dismissed.
    ///
    /// - Parameters:
    ///    - visuals: ``SnackVisuals`` the visual information of the snackbar shown
    ///
    /// - Returns: The ``SnackResult`` result of the asction - either ``.dismissed`` or ``.actionPerformed`` if action
    @discardableResult
    public func showSnack(_ visuals: Visuals) async -> SnackResult {
        await semaphore.wait()
        let result = await withCheckedContinuation(function: "SnackState.showSnack continuation") { continuation in
            currentData = SnackData(visuals: visuals, continuation: continuation)
        }
        currentData = nil
        semaphore.signal()
        
        return result
    }
}

/// Control object for a single snackbar. Provides functionality for dimsmissing the Snackbar using `dismiss()` or `performAction()` functions.
/// Contains all information necessary for displaying the snackbar.
public class SnackData<Visuals: SnackVisuals>: Equatable, Hashable {
    let visuals: Visuals
    private let continuation: CheckedContinuation<SnackResult, Never>
    private var resumed = false
    
    init(visuals: Visuals, continuation: CheckedContinuation<SnackResult, Never>) {
        self.visuals = visuals
        self.continuation = continuation
    }
    
    func performAction() {
        if !resumed {
            continuation.resume(returning: .actionPerformed)
            resumed = true
        }
    }

    /// Dismiss/hide the snackbar that is currently visible. Does nothing if the snackbar is already dismissed.
    public func dismiss() {
        if !resumed {
            continuation.resume(returning: .dismissed)
            resumed = true
        }
    }
    
    public static func == (lhs: SnackData<Visuals>, rhs: SnackData<Visuals>) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(visuals.actionLabel)
        hasher.combine(visuals.message)
        hasher.combine(visuals.duration)
        hasher.combine(resumed)
    }
}
