//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

// sourcery: AutoMockable
public protocol GetRocketLaunchesUseCase {
    func execute() -> AsyncThrowingStream<[RocketLaunch], Error>
}

public struct GetRocketLaunchesUseCaseImpl: GetRocketLaunchesUseCase {
    
    private let rocketLaunchRepository: RocketLaunchRepository
    
    public init(rocketLaunchRepository: RocketLaunchRepository) {
        self.rocketLaunchRepository = rocketLaunchRepository
    }
    
    public func execute() -> AsyncThrowingStream<[RocketLaunch], Error> {
        rocketLaunchRepository.read()
    }
}
