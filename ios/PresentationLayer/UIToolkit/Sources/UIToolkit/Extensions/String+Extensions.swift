//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

public extension String {
    
    var secured: String {
        String(map { _ in "*" })
    }
    
    var initials: String {
        let words: [Substring] = split(separator: " ")
        let initials = words.map { String($0.first ?? Character("")) }
        let userInitials = initials.joined()
        return userInitials
    }
    
    static func placeholder(length: Int) -> String {
        String(Array(repeating: "X", count: length))
    }
}
