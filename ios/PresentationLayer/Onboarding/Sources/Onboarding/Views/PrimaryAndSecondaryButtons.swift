//
//  Created by Petr Chmelar on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct PrimaryAndSecondaryButtons: View {
    
    @Environment(\.isLoading) private var isLoading
    
    private let primaryButtonTitle: String
    private let onPrimaryButtonTap: () -> Void
    
    private let secondaryButtonTitle: String
    private let onSecondaryButtonTap: () -> Void
    
    init(
        primaryButtonTitle: String,
        onPrimaryButtonTap: @escaping () -> Void,
        secondaryButtonTitle: String,
        onSecondaryButtonTap: @escaping () -> Void
    ) {
        self.primaryButtonTitle = primaryButtonTitle
        self.onPrimaryButtonTap = onPrimaryButtonTap
        self.secondaryButtonTitle = secondaryButtonTitle
        self.onSecondaryButtonTap = onSecondaryButtonTap
    }
    
    var body: some View {
        VStack {
            Button(primaryButtonTitle) {
                onPrimaryButtonTap()
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: isLoading))
            .disabled(isLoading)
            
            Button(secondaryButtonTitle) {
                onSecondaryButtonTap()
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding()
    }
}

#if DEBUG
#Preview {
    PrimaryAndSecondaryButtons(
        primaryButtonTitle: "Login",
        onPrimaryButtonTap: {},
        secondaryButtonTitle: "Register",
        onSecondaryButtonTap: {}
    )
}
#endif
