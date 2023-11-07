//
//  Created by Petr Chmelar on 28.01.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    
    let isLogged: Bool
    
    var body: some View {
        if #available(iOS 17.0, *) {
            Text(isLogged ? "✅" : "❌")
                .font(.largeTitle)
                .containerBackground(for: .widget) { Color.white }
        } else {
            Text(isLogged ? "✅" : "❌")
                .font(.largeTitle)
        }
    }
}
