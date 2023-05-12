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
                    ForEach(viewModel.state.urls, id: \.self) { url in
                        RemoteImage(stringURL: url, defaultImage: Asset.Images.brandLogo.image)
                            .frame(width: geo.size.width, height: geo.size.width)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
        }
        .lifecycle(viewModel)
    }
}

#if DEBUG
struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView(viewModel: ImagesViewModel(flowController: nil))
    }
}
#endif
