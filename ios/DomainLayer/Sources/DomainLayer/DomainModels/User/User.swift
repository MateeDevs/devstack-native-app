//
//  Created by Petr Chmelar on 16.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public struct User: Equatable {
    public let id: String
    public let email: String
    public let firstName: String
    public let lastName: String
    public let phone: String
    public let bio: String
    public let pictureUrl: String
    public let counter: Int
    
    public init(
        id: String,
        email: String,
        firstName: String,
        lastName: String,
        phone: String,
        bio: String,
        pictureUrl: String,
        counter: Int
    ) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.bio = bio
        self.pictureUrl = pictureUrl
        self.counter = counter
    }
}

public extension User {
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

// Copy constructor
public extension User {
    init(
        copy: User,
        id: String? = nil,
        email: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        phone: String? = nil,
        bio: String? = nil,
        pictureUrl: String? = nil,
        counter: Int? = nil
    ) {
        self.id = id ?? copy.id
        self.email = email ?? copy.id
        self.firstName = firstName ?? copy.firstName
        self.lastName = lastName ?? copy.lastName
        self.phone = phone ?? copy.phone
        self.bio = bio ?? copy.bio
        self.pictureUrl = pictureUrl ?? copy.pictureUrl
        self.counter = counter ?? copy.counter
    }
}
