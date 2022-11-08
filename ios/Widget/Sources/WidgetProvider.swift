//
//  Created by Tomas Brand on 15.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Resolver
import SharedDomain
import SwiftUI
import Utilities
import WidgetKit

struct WidgetProvider: TimelineProvider {
    
    @ObservedObject private var viewModel: WidgetViewModel = WidgetViewModel()

    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date(), user: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let entry = WidgetEntry(date: Date(), user: viewModel.state.user)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let entry = WidgetEntry(date: Date(), user: viewModel.state.user)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetEntry: TimelineEntry {
    let date: Date
    let user: User?
}

struct DevStackWidgetEntryView: View {
    var entry: WidgetProvider.Entry

    var body: some View {
        WidgetView(viewModel: WidgetViewModel())
    }
}
