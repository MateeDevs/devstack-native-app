//
//  Created by Petr Chmelar on 28/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation

public struct AlertData: Equatable, Identifiable {
    
    public var id: String { title + (message ?? "") }
    
    let title: String
    let message: String?
    let primaryAction: AlertData.Action
    let secondaryAction: AlertData.Action?
    
    public init(
        title: String,
        message: String? = nil,
        primaryAction: AlertData.Action = AlertData.Action(title: L10n.dialog_error_close_text, style: .default),
        secondaryAction: AlertData.Action? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
    
    public static func == (lhs: AlertData, rhs: AlertData) -> Bool {
        lhs.title == rhs.title &&
        lhs.message == rhs.message &&
        lhs.primaryAction == rhs.primaryAction &&
        lhs.secondaryAction == rhs.secondaryAction
    }
}

public extension AlertData {
    struct Action: Equatable {
        let title: String
        let style: Style
        let handler: (() -> Void)
        
        public init(
            title: String,
            style: Style = .default,
            handler: @escaping (() -> Void) = {}
        ) {
            self.title = title
            self.style = style
            self.handler = handler
        }
        
        public static func == (lhs: Action, rhs: Action) -> Bool {
            lhs.title == rhs.title &&
            lhs.style == rhs.style
        }
    }
}

public extension AlertData.Action {
    enum Style {
        case `default`
        case cancel
        case destruction
    }
}
