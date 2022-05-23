//
//  Created by Petr Chmelar on 27.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct HeadlineText: View {
    
    private let content: String
    
    init(_ content: String) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .font(AppTheme.Fonts.headlineText)
            .foregroundColor(AppTheme.Colors.headlineText)
    }
}

#if DEBUG
struct HeadlineText_Previews: PreviewProvider {
    static var previews: some View {
        HeadlineText("Lorem Ipsum")
    }
}
#endif
