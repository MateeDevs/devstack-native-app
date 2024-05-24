//
//  Created by Julia Jakubcova on 23/05/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI
import UIKit
import UIToolkit

enum VideosFlow: Flow {
    case videos(Videos)
    case pickMedia(mediaURL: (NSURL?) -> Void)
    
    enum Videos: Equatable {
        
    }
}

public final class VideosFlowController: FlowController {
    override public func setup() -> UIViewController {
        let vm = VideosViewModel(flowController: self)
        return BaseHostingController(rootView: VideosView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let videosFlow = flow as? VideosFlow else { return }
        switch videosFlow {
        case .videos(let videosFlow): handleVideosFlow(videosFlow)
        case .pickMedia(mediaURL: let mediaURL): pickMedia(mediaURL: mediaURL)
        }
    }
}

// MARK: Videos flow
extension VideosFlowController {
    func handleVideosFlow(_ flow: VideosFlow.Videos) {
        switch flow {
        }
    }
    
    private func pickMedia(mediaURL: @escaping (NSURL?) -> Void) {
        let fc = ImagePickerFlowController(pickMedia: mediaURL, navigationControler: navigationController)
        let vc = startChildFlow(fc)
        
        if let top = navigationController.presentedViewController {
            top.present(vc, animated: true)
        } else {
            navigationController.present(vc, animated: true)
        }
    }
}
