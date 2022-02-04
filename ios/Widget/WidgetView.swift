//
//  Created by Petr Chmelar on 28.01.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    
    let isLogged: Bool
    
    var body: some View {
        Text(isLogged ? "✅" : "❌")
            .font(.largeTitle)
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(isLogged: true)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
