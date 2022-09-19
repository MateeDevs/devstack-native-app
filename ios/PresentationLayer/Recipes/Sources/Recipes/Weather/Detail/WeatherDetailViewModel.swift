//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import UIToolkit

final class WeatherDetailViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private var cityName: String
    private weak var flowController: FlowController?
    
    @Injected private(set) var getWeatherUseCase: GetWeatherUseCase

    init(cityName: String, flowController: FlowController?) {
        self.cityName = cityName
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task { await loadWeather() })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var weather: Weather?
    }
    
    // MARK: Intent
    enum Intent {
    }

    func onIntent(_ intent: Intent) {}
    
    // MARK: Private
    
    private func loadWeather() async {
        do {
            state.weather = try await getWeatherUseCase.execute(cityName: cityName)
        } catch {}
    }
}
