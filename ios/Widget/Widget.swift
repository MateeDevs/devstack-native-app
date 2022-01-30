//
//  Created by Petr Chmelar on 26.01.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DataLayer
import DomainLayer
import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    
    #warning("TODO: Temporary keychain access, should be obtained via ViewModel's dependencies instead")
    let keychainProvider = SystemKeychainProvider(userDefaultsProvider: SystemUserDefaultsProvider())
    
    func placeholder(in context: Context) -> SimpleEntry {
        let isLogged = keychainProvider.get(.userId) != nil
        return SimpleEntry(date: Date(), isLogged: isLogged)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let isLogged = keychainProvider.get(.userId) != nil
        let entry = SimpleEntry(date: Date(), isLogged: isLogged)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let isLogged = keychainProvider.get(.userId) != nil
        let entry = SimpleEntry(date: Date(), isLogged: isLogged)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let isLogged: Bool
}

struct DevStackWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        WidgetView(isLogged: entry.isLogged)
    }
}

@main
struct DevStackWidget: Widget {
    let kind: String = "DevStackWidget"
    
    init() {
        setupEnvironment()
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
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

struct DevStackWidgetPreviews: PreviewProvider {
    static var previews: some View {
        DevStackWidgetEntryView(entry: SimpleEntry(date: Date(), isLogged: true))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
