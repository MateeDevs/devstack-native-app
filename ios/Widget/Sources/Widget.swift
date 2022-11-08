//
//  Created by Petr Chmelar on 26.01.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import Utilities
import WidgetKit

@main
struct DevStackWidget: Widget {
    let kind: String = "DevStackWidget"
    
    init() {
        setupEnvironment()
        Resolver.registerDependencies()
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WidgetProvider()) { entry in
            DevStackWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("DevStack Widget")
        .description("This is an example widget.")
    }
    
    // MARK: Setup environment
    private func setupEnvironment() {
        #if ALPHA
        Environment.type = .alpha
        #elseif BETA
        Environment.type = .beta
        #elseif PRODUCTION
        Environment.type = .production
        #endif
        
        #if DEBUG
        Environment.flavor = .debug
        #else
        Environment.flavor = .release
        #endif
    }
}
