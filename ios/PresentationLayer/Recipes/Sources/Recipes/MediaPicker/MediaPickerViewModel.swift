//
//  Created by Krystof Prihoda on 18.04.2024.
//  Copyright © 2024 Matee. All rights reserved.
//

import SharedDomain
import UIToolkit
import Foundation
import UIKit
import SwiftUI

final class MediaPickerViewModel: BaseViewModel, ViewModel, ObservableObject {
    
        // MARK: Dependencies
        weak var flowController: FlowController?
    
        init(flowController: FlowController?) {
            self.flowController = flowController
            super.init()
        }
    
        // MARK: Lifecycle
    
        override func onAppear() {
            super.onAppear()
        }
    
        // MARK: State
    
        @Published private(set) var state: State = State()
    
        struct State {
            var isLoading: Bool = false
            var media: [MediaType] = []
        }
    
        // MARK: Intent
        enum Intent {
            case setMedia(_ media: [MediaType])
            case addMedia
        }
        
        func onIntent(_ intent: Intent) {
            executeTask(Task {
                switch intent {
                case .setMedia(let media): setMedia(media)
                case .addMedia: addMedia()
                }
            })
        }
    
        // MARK: Private
    
        private func setMedia(_ media: [MediaType]) {
            state.media = media
        }
    
        private func addMedia() {
            flowController?.handleFlow(RecipesFlow.recipes(.presentPickerModal(delegate: self)))
        }
}

extension MediaPickerViewModel: MediaPickerSource {
    var media: Binding<[MediaType]> {
        Binding<[MediaType]>(
            get: { [weak self] in self?.state.media ?? [] },
            set: { [weak self] media in self?.onIntent(.setMedia(media)) }
        )
    }
}
