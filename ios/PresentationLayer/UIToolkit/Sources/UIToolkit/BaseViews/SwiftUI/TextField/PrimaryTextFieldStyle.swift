//
//  Created by Petr Chmelar on 01.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct PrimaryTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(AppTheme.Fonts.textFieldText)
            .accentColor(AppTheme.Colors.primaryColor)
            .disableAutocorrection(true)
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.Colors.textFieldBorder, lineWidth: 2)
            )
    }
}

#if DEBUG
#Preview {
    TextField("Lorem Ipsum", text: .constant("Lorem Ipsum"))
        .textFieldStyle(PrimaryTextFieldStyle())
}
#endif
