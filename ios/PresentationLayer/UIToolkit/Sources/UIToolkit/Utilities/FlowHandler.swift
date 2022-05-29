//
//  Created by Petr Chmelar on 29.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@MainActor
public protocol FlowHandler {
    associatedtype Flow
    func handleFlow(_ flow: Flow)
}
