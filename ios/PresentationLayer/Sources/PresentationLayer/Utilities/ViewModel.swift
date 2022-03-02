//
//  Created by Petr Chmelar on 21.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

@MainActor
protocol ViewModel {
    associatedtype State
    associatedtype Intent

    var state: State { get }
    
    func intent(_ intent: Intent)
}
