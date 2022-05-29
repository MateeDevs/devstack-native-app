//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct RecipesView: View {
    
    @ObservedObject private var viewModel: RecipesViewModel
    
    init(viewModel: RecipesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            List {
                ForEach(viewModel.state.recipes, id: \.self) { recipe in
                    HStack {
                        Text(recipe.rawValue)
                        Spacer()
                        NavigationLink.empty
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.onIntent(.openRecipe(recipe))
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.recipes_view_toolbar_title)
    }
}

// #if DEBUG
// import Resolver
//
// struct RecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        Resolver.registerUseCasesForPreviews()
//
//        let vm = RecipesViewModel(flowController: nil)
//        return PreviewGroup {
//            RecipesView(viewModel: vm)
//        }
//    }
// }
// #endif
