//
//  Created by David Kadlček on 12.05.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct ImagesView: View {
    
    @ObservedObject private var viewModel: ImagesViewModel

    init(viewModel: ImagesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.state.posts, id: \.self) { post in
                        RemoteImage(stringURL: post.url, placeholder: Asset.Images.brandLogo.image)
                            .equatable()
                            .frame(width: geo.size.width, height: geo.size.width)
                            .onTapGesture {
                                viewModel.onIntent(.likePost(post))
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
        }
        .lifecycle(viewModel)
    }
}

#if DEBUG
#Preview {
    ImagesView(viewModel: ImagesViewModel(flowController: nil))
}
#endif
