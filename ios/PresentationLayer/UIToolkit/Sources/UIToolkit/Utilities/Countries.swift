//
//  Created by Viktor Kaderabek on 30/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Foundation

struct Countries {
    
    ///
    /// Countries and ISO codes from system
    ///
    /// - returns: Dictionary with names and ISO codes
    ///
    static func getCountriesAndCodes() -> [(name: String, code: String)] {
        var countriesAndCodes: [(name: String, code: String)] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: NSLocale.current.languageCode ?? "en")
                .displayName(forKey: NSLocale.Key.identifier, value: id) ?? code
            countriesAndCodes.append((name: name, code: code))
        }
        
        return countriesAndCodes.sorted(by: { $0.name < $1.name })
    }
    
    ///
    /// Convert ISO country code to full country name
    ///
    /// - parameter code: ISO code of a country
    /// - returns: Full country name
    ///
    static func getCountryBy(code: String) -> String? {
        let currentLocale = NSLocale(localeIdentifier: NSLocale.current.languageCode ?? "en")
        let countryName = currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: code)
        return countryName
    }
}
