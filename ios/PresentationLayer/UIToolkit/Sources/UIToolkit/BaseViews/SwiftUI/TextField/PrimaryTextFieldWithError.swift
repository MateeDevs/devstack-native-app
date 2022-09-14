//
//  Created by Adam Penaz on 14.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public struct PrimaryTextFieldWithError: View {
    
    private let titleKey: String
    private let text: Binding<String>
    private let secure: Bool
    private let error: Bool
    
    public init(
        _ titleKey: String,
        text: Binding<String>,
        secure: Bool = false,
        error: Bool = false
    ) {
        self.titleKey = titleKey
        self.text = text
        self.secure = secure
        self.error = error
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            if error {
                Text(titleKey)
                    .font(AppTheme.Fonts.textFieldTitle)
                    .foregroundColor(AppTheme.Colors.whisperBackgroundError)
                if secure {
                    SecureField(titleKey, text: text)
                        .textFieldStyle(PrimaryTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(AppTheme.Colors.whisperBackgroundError, lineWidth: 2)
                        )
                } else {
                    TextField(titleKey, text: text)
                        .textFieldStyle(PrimaryTextFieldStyle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(AppTheme.Colors.whisperBackgroundError, lineWidth: 2)
                        )
                }
            } else {
                PrimaryTextField(titleKey, text: text, secure: secure)
            }
        }
    }
}

#if DEBUG
struct PrimaryTextFieldWithError_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryTextFieldWithError("Lorem Ipsum", text: .constant("Lorem Ipsum"))
            PrimaryTextFieldWithError("Lorem Ipsum", text: .constant("Lorem Ipsum"), secure: true)
            PrimaryTextFieldWithError("Lorem Ipsum", text: .constant("Lorem Ipsum"), error: true)
            PrimaryTextFieldWithError("Lorem Ipsum", text: .constant("Lorem Ipsum"), secure: true, error: true)
        }
    }
}
#endif
