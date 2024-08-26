//
//  Created by David Kadlček on 24.07.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI
import TipKit
import UIToolkit

@available(iOS 17, *)
struct ExampleTipKitView: View {
    
    @ObservedObject private var viewModel: ExampleTipKitViewModel
    
    private var actionTip = ActionTip()
    
    init(viewModel: ExampleTipKitViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 32) {
            Text(L10n.recipe_tipkit_title)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.largeTitle)
                .popoverTip(PopoverTip())
            
            VStack {
                Text(L10n.recipe_tipkit_inline_tip)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                
                TipView(InlineTip())
            }
            
            VStack {
                HStack {
                    Text(L10n.recipe_tipkit_remaining_title(viewModel.state.remainingTapsToShowTip))
                    
                    if viewModel.state.remainingTapsToShowTip > 0 {
                        Button(
                            action: {
                                viewModel.onIntent(.tapToShowTip)
                            }, label: {
                                Text(L10n.recipe_tipkit_decrease_button_title)
                            }
                        )
                    }
                }
                
                VStack {
                    Text(L10n.recipe_tipkit_rule_tip)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                    TipView(RuleTip())
                }
                
                VStack {
                    Text(L10n.recipe_tipkit_action_tip)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                    TipView(actionTip) { action in
                        switch action.id {
                        case ActionTip.Actions.pop.id:
                            viewModel.onIntent(.pop)
                        case ActionTip.Actions.close.id:
                            actionTip.invalidate(reason: .actionPerformed)
                        default:
                            break
                        }
                    }
                }
                .padding(.top)
            }
            
            Spacer()
        }
        .padding()
        .lifecycle(viewModel)
    }
}

#Preview {
    if #available(iOS 17, *) {
        return ExampleTipKitView(viewModel: ExampleTipKitViewModel(flowController: nil))
    } else {
        return EmptyView()
    }
}
