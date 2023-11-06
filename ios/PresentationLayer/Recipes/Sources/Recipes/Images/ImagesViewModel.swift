//
//  Created by David Kadlček on 12.05.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import UIToolkit

final class ImagesViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?

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
        var urls: [String] = [
            "https://picsum.photos/id/1/300/300",
            "https://picsum.photos/id/2/300/300",
            "https://picsum.photos/id/3/300/300",
            "https://picsum.photos/id/4/300/300",
            "https://picsum.photos/id/5/300/300",
            "https://picsum.photos/id/6/300/300",
            "https://picsum.photos/id/7/300/300",
            "https://picsum.photos/id/8/300/300",
            "https://picsum.photos/id/9/300/300",
            "https://picsum.photos/id/10/300/300",
            "https://picsum.photos/id/11/300/300",
            "https://picsum.photos/id/12/300/300",
            "https://picsum.photos/id/13/300/300",
            "https://picsum.photos/id/14/300/300",
            "https://picsum.photos/id/15/300/300",
            "https://picsum.photos/id/16/300/300"
        ]
    }
    
    // MARK: Intent
    enum Intent {
    }

    func onIntent(_ intent: Intent) {}
    
    // MARK: Private
}
