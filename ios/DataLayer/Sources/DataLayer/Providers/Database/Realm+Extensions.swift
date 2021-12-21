//
//  Created by Petr Chmelar on 17/06/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import DomainLayer
import RealmSwift

extension Realm {
    
    // Idea taken from: https://stackoverflow.com/a/56218423
    static func safeInit() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch {
            Logger.error("Error during Realm init:\n%@", "\(error)", category: .app)
        }
        return nil
    }
}
