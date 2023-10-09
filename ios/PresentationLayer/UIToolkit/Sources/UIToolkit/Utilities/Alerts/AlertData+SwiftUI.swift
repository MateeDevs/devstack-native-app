//
//  Created by Petr Chmelar on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public extension Alert {
    init(_ data: AlertData) {
        if let secondaryAction = data.secondaryAction {
            self.init(
                title: Text(data.title),
                message: Text(data.message ?? ""),
                primaryButton: .init(data.primaryAction),
                secondaryButton: .init(secondaryAction)
            )
        } else {
            self.init(
                title: Text(data.title),
                message: Text(data.message ?? ""),
                dismissButton: .init(data.primaryAction)
            )
        }

    }
}

public extension Alert.Button {
    init(_ action: AlertData.Action) {
        switch action.style {
        case .default: self = .default(Text(action.title), action: action.handler)
        case .cancel: self = .cancel(Text(action.title), action: action.handler)
        case .destruction: self = .destructive(Text(action.title), action: action.handler)
        }
    }
}
