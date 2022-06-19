//
//  Created by David Sobisek on 15.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct SecondaryAndPrimaryButtons: View {
    
    private let secondaryButtonTitle: String
    private let onSecondaryButtonTap: () -> Void
    
    private let primaryButtonTitle: String
    private let onPrimaryButtonTap: () -> Void
    
    init(
        secondaryButtonTitle: String,
        onSecondaryButtonTap: @escaping () -> Void,
        primaryButtonTitle: String,
        onPrimaryButtonTap: @escaping () -> Void
    ) {
        self.secondaryButtonTitle = secondaryButtonTitle
        self.onSecondaryButtonTap = onSecondaryButtonTap
        self.primaryButtonTitle = primaryButtonTitle
        self.onPrimaryButtonTap = onPrimaryButtonTap
    }
    
    var body: some View {
        VStack {
            Button(secondaryButtonTitle) {
                onSecondaryButtonTap()
            }
            .buttonStyle(SecondaryButtonStyle())
            
            Button(primaryButtonTitle) {
                onPrimaryButtonTap()
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }
}

#if DEBUG
struct PrimaryAndSecondaryButtons_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryAndPrimaryButtons(
            secondaryButtonTitle: "Edit profile",
            onSecondaryButtonTap: {},
            primaryButtonTitle: "Logout",
            onPrimaryButtonTap: {}
        )
    }
}
#endif
