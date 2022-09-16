//
//  Created by Adam Penaz on 16.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct WeatherView: View {
    
    @ObservedObject private var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            List {
                ForEach(viewModel.state.cities, id: \.self) { city in
                    HStack {
                        Text(city.rawValue)
                        Spacer()
                        NavigationLink.empty
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.onIntent(.openCityDetail(city.rawValue))
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.recipes_view_toolbar_title)
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCaseMocks()
        
        let vm = RecipesViewModel(flowController: nil)
        return PreviewGroup {
            RecipesView(viewModel: vm)
        }
    }
}
#endif
