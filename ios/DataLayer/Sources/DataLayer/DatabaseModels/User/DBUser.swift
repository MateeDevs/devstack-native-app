//
//  Created by Petr Chmelar on 20/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import DomainLayer
import RealmSwift

@objcMembers class DBUser: Object {
    dynamic var id: String = ""
    dynamic var email: String = ""
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var phone: String = ""
    dynamic var bio: String = ""
    dynamic var pictureUrl: String = ""
    dynamic var counter: Int = 0

    override static func primaryKey() -> String? {
        "id"
    }
    
    override var apiModel: [String: Any] {
        var model = super.apiModel
        model.removeValue(forKey: "counter")
        return model
    }
}

// Conversion from DatabaseModel to DomainModel
extension DBUser: DomainRepresentable {
    typealias DomainModel = DomainLayer.User
    
    var domainModel: DomainModel {
        User(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            bio: bio,
            pictureUrl: pictureUrl,
            counter: counter
        )
    }
}

// Conversion from DomainModel to DatabaseModel
extension DomainLayer.User: DatabaseRepresentable {
    typealias DatabaseModel = DBUser
    
    var databaseModel: DatabaseModel {
        let model = DBUser()
        model.id = id
        model.email = email
        model.firstName = firstName
        model.lastName = lastName
        model.phone = phone
        model.bio = bio
        model.pictureUrl = pictureUrl
        model.counter = counter
        return model
    }
}
