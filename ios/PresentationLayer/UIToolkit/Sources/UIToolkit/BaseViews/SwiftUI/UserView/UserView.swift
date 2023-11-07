//
//  Created by Petr Chmelar on 23.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public struct UserView: View {
    
    private let fullName: String
    
    public init(_ fullName: String) {
        self.fullName = fullName
    }
    
    public var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(AppTheme.Colors.primaryColor)
                Text(fullName.initials)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 64)
            Text(fullName)
                .font(.system(size: 20))
                .padding(.top, 16)
        }

    }
}

#if DEBUG
#Preview {
    UserView("Petr Chmelar")
}
#endif
