//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import HealthKit
import SwiftUI
import UIToolkit

enum Recipe: String, CaseIterable {
    case counter = "Counter"
    case books = "Books"
    case rocketLaunches = "RocketLaunches"
    case skeleton = "Skeleton"
    case images = "Images"
    case maps = "Maps"
}

final class RecipesViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        
        let healthStore = HKHealthStore()

        let cycleTrackingType = HKObjectType.categoryType(forIdentifier: .menstrualFlow)!
        let ovulationTestResultType = HKObjectType.categoryType(forIdentifier: .ovulationTestResult)!
        let cervicalMucusQualityType = HKObjectType.categoryType(forIdentifier: .cervicalMucusQuality)!

        let typesToRead: Set = [cycleTrackingType, ovulationTestResultType, cervicalMucusQualityType]

        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                print("Authorization successful")
            } else {
                if let error = error {
                    print("Authorization error: \(error.localizedDescription)")
                }
            }
        }

        let query = HKSampleQuery(sampleType: cycleTrackingType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            if let error = error {
                print("Error fetching cycle tracking data: \(error.localizedDescription)")
                return
            }

            guard let results = results as? [HKCategorySample] else {
                print("No data found")
                return
            }

            for result in results {
                let startDate = result.startDate
                let endDate = result.endDate
                let value = result.value  // The value indicates the type of flow

                print("Cycle tracking data: start date: \(startDate), end date: \(endDate), value: \(value)")
            }
        }

        healthStore.execute(query)
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var recipes: [Recipe] = Recipe.allCases
    }
    
    // MARK: Intent
    enum Intent {
        case openRecipe(_ recipe: Recipe)
    }

    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .openRecipe(let recipe): openRecipe(recipe)
            }
        })
    }
    
    // MARK: Private
    
    private func openRecipe(_ recipe: Recipe) {
        switch recipe {
        case .counter: flowController?.handleFlow(RecipesFlow.recipes(.showCounter))
        case .books: flowController?.handleFlow(RecipesFlow.recipes(.showBooks))
        case .rocketLaunches: flowController?.handleFlow(RecipesFlow.recipes(.showRocketLaunches))
        case .skeleton: flowController?.handleFlow(RecipesFlow.recipes(.showSkeleton))
        case .images: flowController?.handleFlow(RecipesFlow.recipes(.showImages))
        case .maps: flowController?.handleFlow(RecipesFlow.recipes(.showMaps))
        }
    }
}
