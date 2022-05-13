//
//  Created by Petr Chmelar on 04.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct PrimaryAndSecondaryButtons: View {
    
    private let primaryButtonTitle: String
    private let primaryButtonLoading: Bool
    private let onPrimaryButtonTap: () -> Void
    
    private let secondaryButtonTitle: String
    private let onSecondaryButtonTap: () -> Void
    
    init(
        primaryButtonTitle: String,
        primaryButtonLoading: Bool,
        onPrimaryButtonTap: @escaping () -> Void,
        secondaryButtonTitle: String,
        onSecondaryButtonTap: @escaping () -> Void
    ) {
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryButtonLoading = primaryButtonLoading
        self.onPrimaryButtonTap = onPrimaryButtonTap
        self.secondaryButtonTitle = secondaryButtonTitle
        self.onSecondaryButtonTap = onSecondaryButtonTap
    }
    
    var body: some View {
        VStack {
            Button(primaryButtonTitle) {
                onPrimaryButtonTap()
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: primaryButtonLoading))
            .disabled(primaryButtonLoading)
            
            Button(secondaryButtonTitle) {
                onSecondaryButtonTap()
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .padding()
    }
}

#if DEBUG
struct PrimaryAndSecondaryButtons_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryAndSecondaryButtons(
            primaryButtonTitle: "Login",
            primaryButtonLoading: false,
            onPrimaryButtonTap: {},
            secondaryButtonTitle: "Register",
            onSecondaryButtonTap: {}
        )
    }
}
#endif
