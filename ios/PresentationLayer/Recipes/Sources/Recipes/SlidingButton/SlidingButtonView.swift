//
//  Created by David Sobíšek on 18.01.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct SlidingButtonView: View {
    
    @ObservedObject private var viewModel: SlidingButtonViewModel
    
    init(viewModel: SlidingButtonViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            SlidingButton(
                title: viewModel.state.isButtonBlocked ? L10n.recipes_sliding_button_title_unblock : L10n.recipes_sliding_button_title_block,
                buttonIcon: Asset.Images.brandLogo.image,
                color: AppTheme.Colors.primaryColor,
                isLoading: Binding<Bool>(
                    get: { viewModel.state.isLoadingButton },
                    set: { isLoadingButton in
                        viewModel.onIntent(.onIsLoadingButtonChange(isLoadingButton))
                    }
                ),
                maxWidth: geo.size.width - 32
            ) {
                viewModel.onIntent(.onButtonSlide)
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .lifecycle(viewModel)
    }
}

#if DEBUG
#Preview {
    let vm = SlidingButtonViewModel(flowController: nil)
    return SlidingButtonView(viewModel: vm)
}
#endif
