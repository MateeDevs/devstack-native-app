//
//  Created by Tomas Brand on 14.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public extension View {
    @inlinable
    func animation(_ animation: Animation?, if condition: @autoclosure () -> Bool) -> some View {
        self.animation(condition() ? animation : nil)
    }

    @inlinable
    func backgroundColor(_ color: Color) -> some View {
        background(color.edgesIgnoringSafeArea(.all))
    }

    @inlinable
    func frame(_ size: CGSize?, alignment: Alignment = .center) -> some View {
        frame(width: size?.width, height: size?.height, alignment: alignment)
    }

    @inlinable
    func width(_ width: CGFloat?) -> some View {
        frame(width: width)
    }

    @inlinable
    func height(_ height: CGFloat?) -> some View {
        frame(height: height)
    }

    @inlinable
    func maxWidth(_ width: CGFloat?) -> some View {
        frame(maxWidth: width)
    }

    @inlinable
    func maxHeight(_ height: CGFloat?) -> some View {
        frame(maxHeight: height)
    }

    @inlinable
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            hidden()
        } else {
            self
        }
    }

    @inlinable
    func toAnyView() -> AnyView {
        AnyView(self)
    }

    @inlinable
    func shadow(color: Color, blur: CGFloat, opacity: Double = 1, x: CGFloat = 0, y: CGFloat = 0) -> some View {
        shadow(color: color.opacity(opacity), radius: blur / 2, x: x, y: y)
    }
}
