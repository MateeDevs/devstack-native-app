//
//  Created by Petr Chmelar on 21.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import Foundation

class LoginUseCasePreviewMock: LoginUseCase {
    func execute(_ data: LoginData) async throws {}
}

class TrackAnalyticsEventUseCasePreviewMock: TrackAnalyticsEventUseCase {
    func execute(_ event: AnalyticsEvent) {}
}

class GetUsersUseCasePreviewMock: GetUsersUseCase {
    func execute(_ sourceType: SourceType, page: Int) async throws -> [User] {
        [
            User(
                id: "5c1a3d7b4a74580016faadf8",
                email: "petr.chmelar@matee.cz",
                firstName: "Petr",
                lastName: "Chmelar",
                phone: "",
                bio: "",
                pictureUrl: "",
                counter: 0
            ),
            User(
                id: "5c50224464662000177f69a9",
                email: "user1@matee.cz",
                firstName: "User1",
                lastName: "Matee",
                phone: "",
                bio: "",
                pictureUrl: "",
                counter: 0
            )
        ]
    }
}

class GetUserUseCasePreviewMock: GetUserUseCase {
    func execute(_ sourceType: SourceType, id: String) async throws -> User {
        User(
            id: "5c1a3d7b4a74580016faadf8",
            email: "petr.chmelar@matee.cz",
            firstName: "Petr",
            lastName: "Chmelar",
            phone: "",
            bio: "",
            pictureUrl: "",
            counter: 0
        )
    }
}

class GetProfileUseCasePreviewMock: GetProfileUseCase {
    func execute(_ sourceType: SourceType) async throws -> User {
        User(
            id: "5c1a3d7b4a74580016faadf8",
            email: "petr.chmelar@matee.cz",
            firstName: "Petr",
            lastName: "Chmelar",
            phone: "",
            bio: "",
            pictureUrl: "",
            counter: 0
        )
    }
}
