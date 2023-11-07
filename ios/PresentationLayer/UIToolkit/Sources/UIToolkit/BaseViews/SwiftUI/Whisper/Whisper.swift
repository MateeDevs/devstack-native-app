//
//  Created by Petr Chmelar on 03.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct Whisper: View {
    
    private let data: WhisperData
    
    init(_ data: WhisperData) {
        self.data = data
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(data.message)
                    .font(AppTheme.Fonts.whisperMessage)
                    .foregroundColor(AppTheme.Colors.whisperMessage)
                    .padding(.bottom, 5)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: geometry.safeAreaInsets.top + 25,
                alignment: .bottom
            )
            .background(data.style.color)
            .ignoresSafeArea()
        }
    }
}

#if DEBUG
#Preview {
    Group {
        Whisper(WhisperData("Lorem Ipsum"))
        Whisper(WhisperData(error: "Error Ipsum"))
    }
}
#endif
