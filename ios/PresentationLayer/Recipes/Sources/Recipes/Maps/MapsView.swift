//
//  Created by Petr Chmelar on 03.08.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import MapToolkit
import SwiftUI
import UIToolkit

struct MapsView: View {
    
    @ObservedObject private var viewModel: MapsViewModel
    
    init(viewModel: MapsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            GoogleMapsView()
        }
        .lifecycle(viewModel)
    }
}

#if DEBUG
#Preview {
    let vm = MapsViewModel(flowController: nil)
    return MapsView(viewModel: vm)
}
#endif
