//
//  Created by Petr Chmelar on 28.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public struct SecondaryButtonStyle: ButtonStyle {
    
    private let isLarge: Bool
    private let isLoading: Bool
    
    public init(
        isLarge: Bool = true,
        isLoading: Bool = false
    ) {
        self.isLarge = isLarge
        self.isLoading = isLoading
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
            } else {
                configuration.label
                    .font(AppTheme.Fonts.secondaryButton)
                    .foregroundColor(AppTheme.Colors.secondaryButtonTitle)
                    .padding()
            }
        }
        .frame(maxWidth: isLarge ? .infinity : nil, minHeight: 24)
        .padding()
        .cornerRadius(5)
    }
}

#if DEBUG
struct SecondaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Lorem Ipsum") {}
                .buttonStyle(SecondaryButtonStyle())
            Button("Lorem Ipsum") {}
                .buttonStyle(SecondaryButtonStyle(isLoading: true))
            Button("Lorem Ipsum") {}
                .buttonStyle(SecondaryButtonStyle(isLarge: false))
            Button("Lorem Ipsum") {}
                .buttonStyle(SecondaryButtonStyle(isLarge: false, isLoading: true))
        }
    }
}
#endif
