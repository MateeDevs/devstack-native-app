//
//  Created by Petr Chmelar on 07.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

#if DEBUG
import CoreLocation
import DependencyInjection
import KMPShared
import Factory
@testable import SharedDomain
import SharedDomainMocks

public extension Container {
    func registerUseCaseMocks() {
        
        // Analytics
        trackAnalyticsEventUseCase.register { TrackAnalyticsEventUseCaseSpy() }
        
        // Sample
        getSampleTextUseCase.register { GetSampleTextUseCaseMock(executeReturnValue: ResultSuccess(data: SampleText.stub)) }
    }
}
#endif
