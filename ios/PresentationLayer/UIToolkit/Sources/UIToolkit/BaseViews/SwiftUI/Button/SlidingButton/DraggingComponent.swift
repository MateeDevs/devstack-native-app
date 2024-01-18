//
//  Created by David Sobíšek on 23.11.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI

struct DraggingComponent: View {
    
    private let buttonIcon: Image
    private let color: Color
    @Binding private var isLoading: Bool
    private let maxWidth: CGFloat
    private let minWidth: CGFloat
    @State private var width: CGFloat
    private let action: () -> Void
    private let threshold: CGFloat
    
    init(
        buttonIcon: Image,
        color: Color,
        isLoading: Binding<Bool>,
        maxWidth: CGFloat,
        minWidth: CGFloat = 50,
        width: CGFloat = 50,
        action: @escaping () -> Void = {}
    ) {
        self.buttonIcon = buttonIcon
        self.color = color
        self._isLoading = isLoading
        self.maxWidth = maxWidth
        self.minWidth = minWidth
        self.width = width
        self.action = action
        self.threshold = 0.6 * maxWidth
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            color
                .frame(width: width, height: 50)
                .cornerRadius(25)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.width > 0,
                               width != maxWidth,
                               value.translation.width + minWidth <= maxWidth {
                                width = value.translation.width + minWidth
                            }
                        }
                        .onEnded { _ in
                            if width < threshold || isLoading {
                                width = minWidth
                            } else {
                                width = maxWidth
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isLoading = true
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    action()
                                    width = minWidth
                                }
                            }
                        }
                )
            
            Group {
                if !isLoading {
                    buttonIcon
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(color)
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(color)
                }
            }
            .frame(width: 24)
            .padding(.horizontal, 9)
            .padding(.vertical, 12)
            .background(AppTheme.Colors.primaryButtonTitle)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.25), radius: 2.5, y: 2)
            .allowsHitTesting(false)
            .padding(.trailing, 3)
        }
        .animation(.spring(response: 0.3, dampingFraction: 1, blendDuration: 0), value: width)
    }
}

#if DEBUG
#Preview {
    GeometryReader { geo in
        DraggingComponent(
            buttonIcon: Image(systemName: "xmark"),
            color: AppTheme.Colors.primaryButtonBackground,
            isLoading: .constant(false),
            maxWidth: geo.size.width
        )
    }
}
#endif
