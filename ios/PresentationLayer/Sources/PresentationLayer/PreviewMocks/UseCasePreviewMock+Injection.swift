//
//  Created by Petr Chmelar on 21.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Resolver

public extension Resolver {
    static func registerUseCasesForPreviews() {
        // Analytics
        register { TrackAnalyticsEventUseCasePreviewMock() as TrackAnalyticsEventUseCase }
        
        // Auth
        register { LoginUseCasePreviewMock() as LoginUseCase }
    }
}
