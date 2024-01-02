//
//  Created by Tereza Chodurová on 02.01.2024
//  Copyright © 2024 Matee. All rights reserved.
//

public protocol RequestUserReviewUseCase {
    func execute()
}

public struct RequestUserReviewUseCaseImpl: RequestUserReviewUseCase {
    private let storeKitRepository: StoreKitRepository
    
    public init(
        storeKitRepository: StoreKitRepository
    ) {
        self.storeKitRepository = storeKitRepository
    }
    
    public func execute() {
        storeKitRepository.requestReview()
    }
}
