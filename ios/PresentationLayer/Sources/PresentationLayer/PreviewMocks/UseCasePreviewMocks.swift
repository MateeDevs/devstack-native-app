//
//  Created by Petr Chmelar on 21.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Foundation
import RxSwift

class LoginUseCasePreviewMock: LoginUseCase {
    func execute(_ data: LoginData) -> Observable<Void> { .just(()) }
}

class TrackAnalyticsEventUseCasePreviewMock: TrackAnalyticsEventUseCase {
    func execute(_ event: AnalyticsEvent) {}
}
