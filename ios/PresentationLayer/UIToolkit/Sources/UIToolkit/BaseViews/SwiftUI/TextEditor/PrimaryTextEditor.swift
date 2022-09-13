//
//  Created by Adam Penaz on 12.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public struct PrimaryTextEditor: View {
    
    private let titleKey: String
    private let text: Binding<String>
    
    public init(
        _ titleKey: String,
        text: Binding<String>
    ) {
        self.titleKey = titleKey
        self.text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(titleKey)
                .font(AppTheme.Fonts.textFieldTitle)
                .foregroundColor(AppTheme.Colors.textFieldTitle)
            TextEditor(text: text)
                .font(AppTheme.Fonts.textFieldText)
                .accentColor(AppTheme.Colors.primaryColor)
                .disableAutocorrection(true)
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                .lineSpacing(5)
                .frame(height: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(AppTheme.Colors.textFieldBorder, lineWidth: 2)
                )
        }
    }
}

#if DEBUG
struct PrimaryTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryTextEditor("Lorem Ipsum", text: .constant("Lorem Ipsum"))
        }
    }
}
#endif
