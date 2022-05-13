//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol UserRepository: AutoMockable {
    func create(_ data: RegistrationData) async throws -> User
    func read(_ sourceType: SourceType, id: String) async throws -> User
    func read(_ sourceType: SourceType, page: Int, sortBy: String?) async throws -> [User]
    func update(_ sourceType: SourceType, user: User) async throws -> User
    
    func createRx(_ data: RegistrationData) -> Observable<User>
    func readRx(_ sourceType: SourceType, id: String) -> Observable<User>
    func readRx(_ sourceType: SourceType, page: Int, sortBy: String?) -> Observable<[User]>
    func updateRx(_ sourceType: SourceType, user: User) -> Observable<User>
}
