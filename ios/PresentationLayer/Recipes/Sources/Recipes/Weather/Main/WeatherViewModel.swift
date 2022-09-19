//
//  Created by Adam Penaz on 16.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

enum City: String, CaseIterable {
    case paris = "Paris"
    case newYork = "New York"
    case london = "London"
    case prague = "Prague"
    case bangkok = "Bangkok"
    case hongKong = "Hong Kong"
    case dubai = "Dubai"
    case singapore = "Singapore"
    case rome = "Rome"
    case tokyo = "Tokyo"
}

final class WeatherViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var cities: [City] = City.allCases
    }
    
    // MARK: Intent
    enum Intent {
        case openCityDetail(_ cityName: String)
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .openCityDetail(let cityName): openCityDetail(cityName)
            }
        })
    }
    
    // MARK: Private
    
    private func openCityDetail(_ cityName: String) {
        flowController?.handleFlow(RecipesFlow.weather(.showWeatherDetail(cityName)))
    }
}
