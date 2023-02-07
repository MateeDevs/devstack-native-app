//
//  Created by Petr Chmelar on 07.02.2023
//  Copyright © 2023 Matee. All rights reserved.
//

struct KeychainConfiguration {
    let name: String
    let path: String
    let password: String
}

extension KeychainConfiguration {
    static let fastlane = KeychainConfiguration(
        name: "fastlane",
        path: "~/Library/Keychains/fastlane-db",
        password: randomString()
    )
    
    static func randomString(length: Int = 16) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement() ?? Character("") } )
    }
}
