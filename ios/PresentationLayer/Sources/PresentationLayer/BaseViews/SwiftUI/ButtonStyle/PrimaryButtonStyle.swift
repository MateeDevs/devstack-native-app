//
//  Created by Petr Chmelar on 28.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    private let isLarge: Bool
    
    init(isLarge: Bool = true) {
        self.isLarge = isLarge
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: isLarge ? .infinity : nil)
            .padding()
            .font(Font(AppTheme.Fonts.primaryButton as CTFont))
            .foregroundColor(Color(AppTheme.Colors.primaryButtonTitle))
            .background(Color(AppTheme.Colors.primaryButtonBackground))
            .cornerRadius(5)
    }
}

#if DEBUG
struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Lorem Ipsum") {}
                .buttonStyle(PrimaryButtonStyle())
            
            Button("Lorem Ipsum") {}
                .buttonStyle(PrimaryButtonStyle(isLarge: false))
        }
    }
}
#endif
