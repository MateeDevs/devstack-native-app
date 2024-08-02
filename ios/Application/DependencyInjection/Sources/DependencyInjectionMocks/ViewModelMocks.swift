//
//  Created by Julia Jakubcova on 02/08/2024
//  Copyright © 2024 Matee. All rights reserved.
//

#if DEBUG
import CoreLocation
import DependencyInjection
import KMPShared
import Factory
@testable import SharedDomain
import SharedDomainMocks

public extension Container {
    func registerViewModelMocks() {
        
        // Analytics
        trackAnalyticsEventUseCase.register { TrackAnalyticsEventUseCaseSpy() }
        
        // Sample
        sampleSharedViewModel.register {  SampleSharedViewModel(getSampleText: GetSampleTextUseCaseMock()) }
    }
}
#endif
