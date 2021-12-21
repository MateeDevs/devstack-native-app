//
//  Created by Petr Chmelar on 27.09.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasTrackAnalyticsEventUseCase {
    var trackAnalyticsEventUseCase: TrackAnalyticsEventUseCase { get }
}

public protocol TrackAnalyticsEventUseCase: AutoMockable {
    func execute(_ event: AnalyticsEvent)
}

public struct TrackAnalyticsEventUseCaseImpl: TrackAnalyticsEventUseCase {
    
    public typealias Dependencies =
        HasAnalyticsRepository
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func execute(_ event: AnalyticsEvent) {
        dependencies.analyticsRepository.create(event)
    }
}
