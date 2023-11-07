//
//  Created by Petr Chmelar on 23.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public struct PrimaryProgressView: View {
    
    public init() {}
    
    public var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.Colors.progressView))
            .scaleEffect(2)
    }
}

#if DEBUG
#Preview {
    PrimaryProgressView()
}
#endif
