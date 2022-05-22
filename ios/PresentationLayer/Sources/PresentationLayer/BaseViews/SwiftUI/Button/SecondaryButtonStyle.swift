//
//  Created by Petr Chmelar on 28.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(AppTheme.Fonts.secondaryButton as CTFont))
            .foregroundColor(Color(AppTheme.Colors.secondaryButtonTitle))
            .padding()
    }
}

#if DEBUG
struct SecondaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Lorem Ipsum") {}
            .buttonStyle(SecondaryButtonStyle())
    }
}
#endif
