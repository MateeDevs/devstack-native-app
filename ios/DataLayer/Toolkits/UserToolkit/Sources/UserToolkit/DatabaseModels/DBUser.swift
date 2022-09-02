//
//  Created by Petr Chmelar on 20/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RealmSwift
import SharedDomain

final class DBUser: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var email: String = ""
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var phone: String = ""
    @Persisted var bio: String = ""
    @Persisted var pictureUrl: String = ""
    @Persisted var counter: Int = 0
    
    override var apiModel: [String: Any] {
        var model = super.apiModel
        model.removeValue(forKey: "counter")
        return model
    }
}

// Conversion from DatabaseModel to DomainModel
extension DBUser {
    var domainModel: SharedDomain.User {
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
extension SharedDomain.User {
    var databaseModel: DBUser {
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
