//
//  Created by Adam Penaz on 19.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct WeatherDetailView: View {
    
    @ObservedObject private var viewModel: WeatherDetailViewModel
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            if viewModel.state.isLoading {
                PrimaryProgressView()
            } else {
                Text("\(viewModel.state.weather?.temperatureString ?? "")°C")
                    .font(.system(size: 50))
                    .padding(.top, 16)
                Image(systemName: viewModel.state.weather?.conditionName ?? "cloud")
                    .font(.system(size: 86.0))
                Text(viewModel.state.weather?.cityName ?? "")
                    .font(.system(size: 25))
            }
        }
        .lifecycle(viewModel)
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alert },
            set: { _ in viewModel.onIntent(.dismissAlertAndPop) }
        )) { alert in .init(alert) }
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let vm = WeatherDetailViewModel(cityName: "Prague", flowController: nil)
        return PreviewGroup {
            WeatherDetailView(viewModel: vm)
        }
    }
}
#endif
