//
//  Created by Petr Chmelar on 28.01.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    
    let date: Date
    
    var body: some View {
        if #available(iOS 17.0, *) {
            Text("✅ \(date.ISO8601Format())")
                .font(.largeTitle)
                .containerBackground(for: .widget) { Color.white }
        } else {
            Text("✅ \(date.ISO8601Format())")
                .font(.largeTitle)
        }
    }
}
