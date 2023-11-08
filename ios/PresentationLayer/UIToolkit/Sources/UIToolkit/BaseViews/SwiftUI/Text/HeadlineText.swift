//
//  Created by Petr Chmelar on 27.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public struct HeadlineText: View {
    
    private let content: String
    
    public init(_ content: String) {
        self.content = content
    }
    
    public var body: some View {
        Text(content)
            .font(AppTheme.Fonts.headlineText)
            .foregroundColor(AppTheme.Colors.headlineText)
    }
}

#if DEBUG
#Preview {
    HeadlineText("Lorem Ipsum")
}
#endif
