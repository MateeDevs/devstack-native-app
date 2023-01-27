//
//  Created by Adam Penaz on 27.01.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI

struct RaceDetailView: View {
    
    @ObservedObject private var viewModel: RaceDetailViewModel
    
    init(viewModel: RaceDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("Navigate back") {
            viewModel.onIntent(.onbackButtonTap)
        }
    }
}

#if DEBUG
struct RaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RaceDetailView(viewModel: .init(flowController: nil))
    }
}
#endif
