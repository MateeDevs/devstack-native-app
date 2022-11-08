//
//  Created by Tomas Brand on 02.11.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct ToastView: View {
    
    var type: ToastStyle
    var title: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                type.image
                    .foregroundColor(type.color)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
        }
        .background(
            Capsule()
                .fill(.white)
                .frame(width: .infinity)
                .clipped()
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}
