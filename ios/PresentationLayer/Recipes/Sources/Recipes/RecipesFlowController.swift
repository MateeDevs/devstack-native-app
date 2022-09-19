//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

enum RecipesFlow: Flow, Equatable {
    case recipes(Recipes)
    case weather(Weather)
    
    enum Recipes: Equatable {
        case showCounter
        case showBooks
        case showRocketLaunches
        case showSkeleton
        case showWeather
    }
    
    enum Weather: Equatable {
        case showWeatherDetail(_ cityName: String)
        case pop
    }
}

public final class RecipesFlowController: FlowController {

    override public func setup() -> UIViewController {
        let vm = RecipesViewModel(flowController: self)
        return BaseHostingController(rootView: RecipesView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let recipesFlow = flow as? RecipesFlow else { return }
        switch recipesFlow {
        case .recipes(let recipesFlow): handleRecipesFlow(recipesFlow)
        case .weather(let recipesFlow): handleWeatherFlow(recipesFlow)
        }
    }
}

// MARK: Recipes flow
extension RecipesFlowController {
    func handleRecipesFlow(_ flow: RecipesFlow.Recipes) {
        switch flow {
        case .showCounter: showCounter()
        case .showBooks: showBooks()
        case .showRocketLaunches: showRocketLaunches()
        case .showSkeleton: showSkeleton()
        case .showWeather: showWeather()
        }
    }
    
    private func showCounter() {
        let vm = CounterViewModel(flowController: self)
        let vc = BaseHostingController(rootView: CounterView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showBooks() {
        let vm = BooksViewModel(flowController: self)
        let vc = BaseHostingController(rootView: BooksView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showRocketLaunches() {
        let vm = RocketLaunchesViewModel(flowController: self)
        let vc = BaseHostingController(rootView: RocketLaunchesView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showSkeleton() {
        let vm = SkeletonViewModel(flowController: self)
        let vc = BaseHostingController(rootView: SkeletonView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showWeather() {
        let vm = WeatherViewModel(flowController: self)
        let vc = BaseHostingController(rootView: WeatherView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}

// MARK: Weather flow
extension RecipesFlowController {
    func handleWeatherFlow(_ flow: RecipesFlow.Weather) {
        switch flow {
        case .showWeatherDetail(let cityName): showWeatherDetail(cityName)
        case .pop: pop()
        }
    }
    
    private func showWeatherDetail(_ cityName: String) {
        let vm = WeatherDetailViewModel(cityName: cityName, flowController: self)
        let vc = BaseHostingController(rootView: WeatherDetailView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}
