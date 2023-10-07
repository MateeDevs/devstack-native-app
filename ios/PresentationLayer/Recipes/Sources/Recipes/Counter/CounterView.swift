//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct CounterView: View {
    
    @ObservedObject private var viewModel: CounterViewModel
    
    init(viewModel: CounterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            HStack {
                Button(L10n.counter_view_counter_increase_button) {
                    viewModel.onIntent(.increase)
                }
                .buttonStyle(SecondaryButtonStyle())
                Button(L10n.counter_view_counter_decrease_button) {
                    viewModel.onIntent(.decrease)
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            Text(String(viewModel.state.value))
                .font(.system(size: 40, weight: .bold))
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.counter_view_toolbar_title)
        .toastView(Binding<ToastData?>(
            get: { viewModel.state.toastData },
            set: { _ in viewModel.onIntent(.dismissToast) }
        ))
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        Container.shared.registerUseCaseMocks()
        
        let vm = CounterViewModel(flowController: nil)
        return PreviewGroup {
            CounterView(viewModel: vm)
        }
    }
}
#endif
