//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import RxSwift

public struct UserRepositoryImpl: UserRepository {
    
    private let newDatabase: NewDatabaseProvider
    private let database: DatabaseProvider
    private let network: NetworkProvider
    
    public init(
        newDatabaseProvider: NewDatabaseProvider,
        databaseProvider: DatabaseProvider,
        networkProvider: NetworkProvider
    ) {
        newDatabase = newDatabaseProvider
        database = databaseProvider
        network = networkProvider
    }
    
    public func create(_ data: RegistrationData) async throws -> User {
        guard let data = data.networkModel.encoded else { throw CommonError.encoding }
        let endpoint = AuthAPI.registration(data)
        let user = try await network.request(endpoint).map(NETUser.self).domainModel
        try newDatabase.update(user.databaseModel)
        return user
    }
    
    public func createRx(_ data: RegistrationData) -> Observable<User> {
        guard let data = data.networkModel.encoded else { return .error(CommonError.encoding) }
        let endpoint = AuthAPI.registration(data)
        return network.observableRequest(endpoint).map(NETUser.self).mapToDatabase().save(to: database).mapToDomain()
    }
    
    public func read(_ sourceType: SourceType, id: String) async throws -> User {
        switch sourceType {
        case .local:
            return try newDatabase.read(DBUser.self, id: id).domainModel
        case .remote:
            let endpoint = UserAPI.readUserById(id)
            let user = try await network.request(endpoint).map(NETUser.self).domainModel
            try newDatabase.update(user.databaseModel)
            return user
        }
    }
    
    public func readRx(_ sourceType: SourceType, id: String) -> Observable<User> {
        let db = database.observableObject(DBUser.self, id: id)
        let endpoint = UserAPI.readUserById(id)
        let net = network.observableRequest(endpoint).map(NETUser.self).mapToDatabase().save(to: database)
        return sourceType.result(db: db.mapToDomain(), net: net.mapToDomain())
    }
    
    public func read(_ sourceType: SourceType, page: Int, sortBy: String?) async throws -> [User] {
        switch sourceType {
        case .local:
            return try newDatabase.read(DBUser.self, sortBy: sortBy).map { $0.domainModel }
        case .remote:
            let endpoint = UserAPI.readUsersForPage(page)
            let users = try await network.request(endpoint).map([NETUser].self, atKeyPath: "data").map { $0.domainModel }
            try newDatabase.update(users.map { $0.databaseModel })
            return users
        }
    }
    
    public func readRx(_ sourceType: SourceType, page: Int, sortBy: String?) -> Observable<[User]> {
        let db = database.observableCollection(DBUser.self, sortBy: sortBy)
        let endpoint = UserAPI.readUsersForPage(page)
        let net = network.observableRequest(endpoint).map([NETUser].self, atKeyPath: "data").mapToDatabase().save(to: database)
        return sourceType.result(db: db.mapToDomain(), net: net.mapToDomain())
    }
    
    public func update(_ sourceType: SourceType, user: User) async throws -> User {
        switch sourceType {
        case .local:
            return try newDatabase.update(user, model: .fullModel)
        case .remote:
            guard let data = user.networkModel.encoded else { throw CommonError.encoding }
            let endpoint = UserAPI.updateUserById(user.id, data: data)
            let user = try await network.request(endpoint).map(NETUser.self).domainModel
            try newDatabase.update(user.databaseModel)
            return user
        }
    }
    
    public func updateRx(_ sourceType: SourceType, user: User) -> Observable<User> {
        let db = database.save(user.databaseModel, model: .fullModel)
        guard let data = user.networkModel.encoded else { return .error(CommonError.encoding) }
        let endpoint = UserAPI.updateUserById(user.id, data: data)
        let net = network.observableRequest(endpoint).map(NETUser.self).mapToDatabase().save(to: database)
        return sourceType.result(db: db.mapToDomain(), net: net.mapToDomain())
    }
}
