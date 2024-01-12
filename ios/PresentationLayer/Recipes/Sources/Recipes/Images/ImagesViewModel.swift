//
//  Created by David Kadlček on 12.05.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import UIToolkit

struct ImagePost: Hashable {
    let url: String
    var isLiked: Bool
}

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
        var posts: [ImagePost] = [
            ImagePost(url: "https://picsum.photos/id/1/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/2/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/3/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/4/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/5/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/6/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/7/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/8/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/9/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/10/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/11/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/12/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/13/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/14/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/15/300/300", isLiked: false),
            ImagePost(url: "https://picsum.photos/id/16/300/300", isLiked: false)
        ]
    }
    
    // MARK: Intent
    enum Intent {
        case likePost(ImagePost)
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .likePost(let post): likePost(post)
            }
        })
    }
    
    // MARK: Private
    
    private func likePost(_ post: ImagePost) {
        state.posts = state.posts.map {
            var mutablePost = $0
            if mutablePost.url == post.url {
                mutablePost.isLiked = !mutablePost.isLiked
            }
            return mutablePost
        }
    }
}
