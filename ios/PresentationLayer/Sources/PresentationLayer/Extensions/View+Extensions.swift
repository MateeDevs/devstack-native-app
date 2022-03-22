//
//  Created by Petr Chmelar on 12.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

@MainActor
public extension View {
    @inlinable func lifecycle(_ viewModel: BaseViewModel) -> some View {
        self
            .onAppear {
                viewModel.onAppear()
            }
            .onDisappear {
                viewModel.onDisappear()
            }
    }
}
