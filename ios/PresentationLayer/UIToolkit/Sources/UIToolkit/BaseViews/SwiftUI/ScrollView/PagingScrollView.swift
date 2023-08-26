//
//  Created by Tomáš Batěk on 10.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI

/// A Scroll View with the ability to call a certain functionality at a given percentage of scroll
/// - note: Taken from https://stackoverflow.com/questions/68681075/how-do-i-detect-when-user-has-reached-the-bottom-of-the-scrollview
public struct PagingScrollView<Content: View>: View {
    
    @State private var wholeSize: CGSize = .zero
    @State private var scrollViewSize: CGSize = .zero
    
    @Namespace private var coordinateSpace
    
    private let axes: SwiftUI.Axis.Set
    private let showsIndicators: Bool
    private let isFetchingMore: Bool
    private let triggerPoint: Double
    private let touchedBottomAction: (() -> Void)?
    private let content: Content
    
    /// - parameters:
    ///  - axes: The scroll view axes
    ///  - showIndicators: Whether the scroll indicators are shown
    ///  - isFetchingMore: Whether data is currently being fetched – this prevents from calling `touchedBottomAction` again
    ///  - triggerPoint: At which point the `touchedBottomAction` should be triggered, 0.0 would be at the very top, 1.0 at the very bottom
    ///  - touchedBottomAction: The function that should be called when the trigger point is reached
    ///  - content: The content for the scroll view
    public init(
        _ axes: SwiftUI.Axis.Set = .vertical,
        showsIndicators: Bool = true,
        triggerPoint: Double = 1.0,
        isFetchingMore: Bool,
        touchedBottomAction: (() -> Void)?,
        @ViewBuilder content: () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.triggerPoint = triggerPoint
        self.isFetchingMore = isFetchingMore
        self.touchedBottomAction = touchedBottomAction
        self.content = content()
    }
    
    public var body: some View {
        ChildSizeReader(
            size: $wholeSize,
            content: {
                ScrollView(axes, showsIndicators: showsIndicators) {
                    innerChildReader()
                }
                .coordinateSpace(name: coordinateSpace)
            }
        )
    }
    
    private var actualTriggerPoint: CGFloat {
        switch axes {
        case .horizontal: return triggerPoint * scrollViewSize.width - wholeSize.width
        default: return triggerPoint * scrollViewSize.height - wholeSize.height
        }
    }
    
    private func preferenceValue(geometry: GeometryProxy) -> CGFloat {
        switch axes {
        case .horizontal: return -geometry.frame(in: .named(coordinateSpace)).origin.x
        default: return -geometry.frame(in: .named(coordinateSpace)).origin.y
        }
    }
    
    private func innerChildReader() -> some View {
        ChildSizeReader(
            size: $scrollViewSize,
            content: {
                content
                    .background(
                        GeometryReader {
                            Color.clear.preference(
                                key: ViewOffsetKey.self,
                                value: preferenceValue(geometry: $0)
                            )
                        }
                    )
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        guard !isFetchingMore,
                              value != 0,
                              value >= actualTriggerPoint
                        else { return }
                        touchedBottomAction?()
                    }
            }
        )
    }
}

#if DEBUG
struct PagingScrollView_Previews: PreviewProvider {
    
    static var previews: some View {
        PagingScrollView(
            isFetchingMore: false,
            touchedBottomAction: nil,
            content: {
                Text("Hello world!")
            }
        )
    }
}
#endif
