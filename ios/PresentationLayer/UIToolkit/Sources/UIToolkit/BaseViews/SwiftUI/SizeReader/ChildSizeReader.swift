//
//  Created by Tomáš Batěk on 10.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI

struct ChildSizeReader<Content: View>: View {
    
    @Binding var size: CGSize
    
    private let content: Content
    
    init(
        size: Binding<CGSize>,
        @ViewBuilder content: () -> Content
    ) {
        self._size = size
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(
                            key: SizePreferenceKey.self,
                            value: proxy.size
                        )
                    }
                )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            DispatchQueue.main.async {
                self.size = preferences
            }
        }
    }
}
