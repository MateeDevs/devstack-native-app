//
//  Created by Petr Chmelar on 01.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct PrimaryTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(Font(AppTheme.Fonts.textFieldText as CTFont))
            .accentColor(Color(AppTheme.Colors.primaryColor))
            .disableAutocorrection(true)
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(AppTheme.Colors.textFieldBorder), lineWidth: 2)
            )
    }
}

#if DEBUG
struct PrimaryTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Lorem Ipsum", text: .constant("Lorem Ipsum"))
            .textFieldStyle(PrimaryTextFieldStyle())
    }
}
#endif
