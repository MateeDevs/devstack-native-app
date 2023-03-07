//
//  InfoErrorSnackHost.swift
//
//
//  Created by Filip Wiesner on 15.01.2023.
//

import Foundation
import SwiftUI

public enum InfoErrorSnackVisuals: SnackVisuals {
    case info(message: String, duration: Int = defaultDuration)
    case error(message: String, actionLabel: String?, duration: Int = defaultDuration)
    
    public var message: String {
        switch self {
        case .info(message: let message, duration: _): return message
        case .error(message: let message, actionLabel: _, duration: _): return message
        }
    }
    
    public var actionLabel: String? {
        switch self {
        case .info: return nil
        case .error(message: _, actionLabel: let actionLabel, duration: _): return actionLabel
        }
    }
    
    public var duration: Int {
        switch self {
        case .info(message: _, duration: let duration): return duration
        case .error(message: _, actionLabel: _, duration: let duration): return duration
        }
    }
    
    public static let defaultDuration: Int = 3
}

public struct InfoErrorSnackHost: View {
    @ObservedObject var snackState: SnackState<InfoErrorSnackVisuals>
    
    public init(
        snackState: SnackState<InfoErrorSnackVisuals>
    ) {
        self.snackState = snackState
    }
    
    public var body: some View {
        SnackHost(state: snackState) { data in
            HStack {
                Text(data.visuals.message)
                Spacer()
                if let action = data.visuals.actionLabel {
                    Button(
                        action: { data.performAction() },
                        label: { Text(action) }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(data.visuals.backgroundColor)
            .foregroundColor(data.visuals.foregroundColor)
            .cornerRadius(4)
            .shadow(radius: 1)
            .padding(12)
        }
    }
}

extension InfoErrorSnackVisuals {
    
    var backgroundColor: Color {
        switch self {
            
        case .info: return AppTheme.Colors.whisperBackgroundInfo
        case .error: return AppTheme.Colors.toastErrorColor
        }
    }
    
    var foregroundColor: Color {
        switch self {
            
        case .info: return AppTheme.Colors.whisperMessage
        case .error: return AppTheme.Colors.primaryButtonTitle
        }
    }
}
