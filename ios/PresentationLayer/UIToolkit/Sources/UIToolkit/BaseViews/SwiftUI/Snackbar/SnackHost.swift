//
//  SnackHost.swift
//
//
//  Created by Filip Wiesner on 15.01.2023.
//

import Foundation
import SwiftUI

/// Container for displaying snackbars.
public struct SnackHost<Visuals: SnackVisuals, Snackbar: View>: View {
    @ObservedObject var snackState: SnackState<Visuals>
    @State private var snackTask: Task<(), Error>?
    private let snackView: (SnackData<Visuals>) -> Snackbar
    
    public init(
        state snackState: SnackState<Visuals>,
        @ViewBuilder snackbar: @escaping (SnackData<Visuals>) -> Snackbar
    ) {
        self.snackState = snackState
        self.snackView = snackbar
    }
    
    public var body: some View {
        ZStack {
            if let data = snackState.currentData {
                snackView(data)
                    .id(data)
                    .transition(.snackTransition)
            } else {
                EmptyView()
            }
        }
        .animation(
            .spring(response: 0.3, dampingFraction: 0.9),
            value: snackState.currentData
        )
        .onChange(of: snackState.currentData) { data in
            snackTask?.cancel()
            snackTask = Task {
                guard let snackData = data else { return }
                
                do {
                    try await Task.sleep(nanoseconds: UInt64(snackData.visuals.duration * 1_000_000_000))
                } catch {
                    return
                }
                
                snackData.dismiss()
            }
        }
    }
}

private extension AnyTransition {
    static var snackTransition: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 0.8).combined(with: .opacity),
            removal: .scale(scale: 0.8).combined(with: .opacity)
        )
    }
}
