//
//  Created by Petr Chmelar on 28.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    private let isLarge: Bool
    private let isLoading: Bool
    
    init(
        isLarge: Bool = true,
        isLoading: Bool = false
    ) {
        self.isLarge = isLarge
        self.isLoading = isLoading
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                configuration.label
                    .font(Font(AppTheme.Fonts.primaryButton as CTFont))
                    .foregroundColor(Color(AppTheme.Colors.primaryButtonTitle))
            }
        }
        .frame(maxWidth: isLarge ? .infinity : nil, minHeight: 24)
        .padding()
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
                .buttonStyle(PrimaryButtonStyle(isLoading: true))
            Button("Lorem Ipsum") {}
                .buttonStyle(PrimaryButtonStyle(isLarge: false))
            Button("Lorem Ipsum") {}
                .buttonStyle(PrimaryButtonStyle(isLarge: false, isLoading: true))
        }
    }
}
#endif
