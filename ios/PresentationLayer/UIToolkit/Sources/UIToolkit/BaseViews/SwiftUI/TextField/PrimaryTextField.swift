//
//  Created by Petr Chmelar on 01.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public struct PrimaryTextField: View {
    
    private let titleKey: String
    private let text: Binding<String>
    private let secure: Bool
    
    public init(
        _ titleKey: String,
        text: Binding<String>,
        secure: Bool = false
    ) {
        self.titleKey = titleKey
        self.text = text
        self.secure = secure
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(titleKey)
                .font(AppTheme.Fonts.textFieldTitle)
                .foregroundColor(AppTheme.Colors.textFieldTitle)
            if secure {
                SecureField(titleKey, text: text)
                    .textFieldStyle(PrimaryTextFieldStyle())
            } else {
                TextField(titleKey, text: text)
                    .textFieldStyle(PrimaryTextFieldStyle())
            }
        }
    }
}

#if DEBUG
#Preview {
    VStack {
        PrimaryTextField("Lorem Ipsum", text: .constant("Lorem Ipsum"))
        PrimaryTextField("Lorem Ipsum", text: .constant("Lorem Ipsum"), secure: true)
    }
}
#endif
