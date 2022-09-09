//
//  Created by Petr Chmelar on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct UserEditProfileSaveButton: View {
    
    private let buttonTitle: String
    private let buttonLoading: Bool
    private let onButtonTap: () -> Void
    
    init(
        buttonTitle: String,
        buttonLoading: Bool,
        onButtonTap: @escaping () -> Void
    ) {
        self.buttonTitle = buttonTitle
        self.buttonLoading = buttonLoading
        self.onButtonTap = onButtonTap
    }
    
    var body: some View {
        VStack {
            Button(buttonTitle) {
                onButtonTap()
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: buttonLoading))
            .disabled(buttonLoading)
        }
        .padding()
    }
}

#if DEBUG
struct UserEditProfileSaveButton_Previews: PreviewProvider {
    static var previews: some View {
        UserEditProfileSaveButton(
            buttonTitle: "Save",
            buttonLoading: false,
            onButtonTap: {}
        )
    }
}
#endif
