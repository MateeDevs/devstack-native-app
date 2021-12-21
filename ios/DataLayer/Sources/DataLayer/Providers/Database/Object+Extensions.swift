//
//  Created by Petr Chmelar on 28/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension Object {
    
    /// Model for partial updates of Realm objects (to prevent overwriting optional existing attributes).
    /// - Just override apiModel() function in your object's class and remove properties you don't want to be updated
    /// - Idea taken from [GitHub Realm Issue #4882](https://github.com/realm/realm-cocoa/issues/4882#issuecomment-295613895)
    /// - Doesn't work for nested objects :(
    @objc var fullModel: [String: Any] {
        var model: [String: Any] = [:]
        let schema = RLMSchema.partialShared().schema(forClassName: String(describing: type(of: self).self))
        if let schema = schema {
            for property in schema.properties {
                model[property.name] = value(forKey: property.name)
            }
        }
        return model
    }
    
    @objc var apiModel: [String: Any] {
        fullModel
    }
}
