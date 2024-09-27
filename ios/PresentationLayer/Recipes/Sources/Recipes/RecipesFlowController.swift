//
//  Created by Petr Chmelar on 28.01.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

enum RecipesFlow: Flow, Equatable {
    case recipes(Recipes)
    
    enum Recipes: Equatable {
        static func == (lhs: RecipesFlow.Recipes, rhs: RecipesFlow.Recipes) -> Bool {
            switch (lhs, rhs) {
            case (.showCounter, .showCounter): true
            case (.showBooks, .showBooks): true
            case (.showSkeleton, .showSkeleton): true
            case (.showImages, .showImages): true
            case (.showMaps, .showMaps): true
            case (.showMedia, .showMedia): true
            case (.presentPickerModal, .presentPickerModal): true
            default: false
            }
        }
        
        case showCounter
        case showBooks
        case showRocketLaunches
        case showSkeleton
        case showImages
        case showMaps
        case showSlidingButton
        case showTipKitExample
        case showMediaPicker
        case showMedia
        case presentPickerModal(delegate: MediaPickerSource)
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
        case .showImages: showImages()
        case .showMaps: showMaps()
        case .showSlidingButton: showSlidingButton()
        case .showTipKitExample: showTipKitExample()
        case .showMediaPicker: showMediaPicker()
        case .showMedia: showMedia()
        case .presentPickerModal(let source): presentPickerModal(source: source)
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
    
    private func showImages() {
        let vm = ImagesViewModel(flowController: self)
        let vc = BaseHostingController(rootView: ImagesView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showMaps() {
        let vm = MapsViewModel(flowController: self)
        let vc = BaseHostingController(rootView: MapsView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showSlidingButton() {
        let vm = SlidingButtonViewModel(flowController: self)
        let vc = BaseHostingController(rootView: SlidingButtonView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showTipKitExample() {
        guard #available(iOS 17, *) else { return }
        
        let vm = ExampleTipKitViewModel(flowController: self)
        let vc = BaseHostingController(rootView: ExampleTipKitView(viewModel: vm))
        navigationController.show(vc, sender: nil)
        
    private func showMediaPicker() {
        let vm = MediaPickerViewModel(flowController: self)
        let vc = BaseHostingController(rootView: MediaPickerView(viewModel: vm))

    private func showMedia() {
        let vm = MediaViewModel(flowController: self)
        let vc = BaseHostingController(rootView: MediaView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func presentPickerModal(source: MediaPickerSource) {
        let vc = BaseHostingController(
            rootView: MediaPickerView(
                media: source.media,
                selectionLimit: 5
            )
        )
        navigationController.present(vc, animated: true)
    }
}
