//
//  Created by Petr Chmelar on 28.01.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit
import WidgetKit

struct WidgetView: View {
    
    @Environment(\.widgetFamily) var family
    @ObservedObject private var viewModel: WidgetViewModel
    
    init(viewModel: WidgetViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        smallWidget
            .lifecycle(viewModel)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    viewModel.onIntent(.test)
                }
            }
    }
    
    private var smallWidget: some View {
        if let user = viewModel.state.user {
            return VStack(alignment: .leading, spacing: 12) {
                if #available(iOSApplicationExtension 15.0, *) {
                    AsyncImage(url: URL(string: user.pictureUrl))
                } else {
                    // Fallback on earlier versions
                }
                Text(user.fullName)
            }
            .padding(.all, 16)
            .background(Color.white)
            .toAnyView()
        } else {
            return errorView
                .foregroundColor(.black)
                .toAnyView()
        }
    }

    private var errorView: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                Image("")
                Text("No data to display")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                Spacer()
            }
            Spacer()
        }
        .background(Color.white)
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(viewModel: WidgetViewModel())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
