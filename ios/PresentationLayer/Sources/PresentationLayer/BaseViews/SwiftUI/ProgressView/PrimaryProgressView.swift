//
//  Created by Petr Chmelar on 23.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct PrimaryProgressView: View {
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.Colors.progressView))
            .scaleEffect(2)
    }
}

#if DEBUG
struct PrimaryProgressView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryProgressView()
    }
}
#endif
