//
//  KotlinDomain+Extensions.swift
//  DomainLayer
//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation

extension DevstackKmpShared.User {
    func toSwiftUser() -> User {
        User(id: self.id,
             email: self.email,
             firstName: self.firstName,
             lastName: self.lastName,
             phone: self.phone ?? "",
             bio: self.bio,
             pictureUrl: "pictureUrl",
             counter: 0)
    }
}
