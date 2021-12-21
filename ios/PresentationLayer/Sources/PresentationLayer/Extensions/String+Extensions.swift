//
//  Created by Petr Chmelar on 04/02/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

extension String {
    
    var secured: String {
        String(map { _ in "*" })
    }
    
    var initials: String {
        let words: [Substring] = split(separator: " ")
        let initials = words.map { String($0.first ?? Character("")) }
        let userInitials = initials.joined()
        return userInitials
    }
    
    /// Conversion from String to Date using a given formatter.
    func toDate(formatter: DateFormatter = Formatter.dateDefault) -> Date? {
        formatter.date(from: self)
    }
    
    ///
    /// Checks whether a given email is valid
    ///
    /// - parameter email: Email to be checked
    /// - returns: True or false
    ///
    var isValidEmail: Bool {
        do {
            let regex = try NSRegularExpression(
                pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$",
                options: [NSRegularExpression.Options.caseInsensitive]
            )
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
        } catch _ as NSError {
            return false
        }
    }
    
    ///
    /// Checks whether a given password meets requirements
    ///
    /// - parameter password: Password to be checked
    /// - parameter length: Minimum required length
    /// - parameter lowercase: Specify whether at least one lowercase letter is required
    /// - parameter uppercase: Specify whether at least one uppercase letter is required
    /// - parameter number: Specify whether at least one number is required
    /// - parameter special: Specify whether at least one special character is required
    /// - returns: Error message, nil in case of valid password
    ///
    func validatePassword(
        _ password: String,
        length: Int = 8,
        lowercase: Bool = false,
        uppercase: Bool = false,
        number: Bool = false,
        special: Bool = false
    ) -> String? {
        if password.count < 8 {
            return L10n.password_validation_length
        } else if lowercase, password.range(of: #"[a-z]"#, options: .regularExpression) == nil {
            return L10n.password_validation_lowercase
        } else if uppercase, password.range(of: #"[A-Z]"#, options: .regularExpression) == nil {
            return L10n.password_validation_uppercase
        } else if number, password.range(of: #"[0-9]"#, options: .regularExpression) == nil {
            return L10n.password_validation_number
        } else if special, password.range(of: #"[!&^%$#@()/]"#, options: .regularExpression) == nil {
            return L10n.password_validation_symbol
        } else {
            return nil
        }
    }
}
