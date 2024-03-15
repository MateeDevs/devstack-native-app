//
//  Created by David Sobíšek on 23.11.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI

public struct SlidingButton: View {
    
    private let title: String
    private let buttonIcon: Image
    private let color: Color
    @Binding private var isLoading: Bool
    private let maxWidth: CGFloat
    private let action: () -> Void
    
    public init(
        title: String,
        buttonIcon: Image,
        color: Color,
        isLoading: Binding<Bool>,
        maxWidth: CGFloat,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.buttonIcon = buttonIcon
        self.color = color
        self._isLoading = isLoading
        self.maxWidth = maxWidth
        self.action = action
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 25)
                .fill(color)
                .frame(height: 50)
            
            Text(title)
                .padding(.leading, maxWidth * 0.2)
                .font(AppTheme.Fonts.primaryButton)
                .foregroundColor(AppTheme.Colors.primaryButtonTitle)
            
            DraggingComponent(
                buttonIcon: buttonIcon,
                color: color,
                isLoading: $isLoading,
                maxWidth: maxWidth,
                action: action
            )
        }
    }
}

#if DEBUG
#Preview {
    GeometryReader { geo in
        SlidingButton(
            title: "Zablokovat",
            buttonIcon: Image(systemName: "xmark"),
            color: AppTheme.Colors.primaryButtonBackground,
            isLoading: .constant(false),
            maxWidth: geo.size.width
        )
    }
}
#endif
