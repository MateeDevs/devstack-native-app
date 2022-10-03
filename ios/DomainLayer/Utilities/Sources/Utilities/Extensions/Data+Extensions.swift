//
//  Created by Petr Chmelar on 03.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation

public extension Data {
    func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil) throws -> D {
        if let keyPath {
            let toplevel = try JSONSerialization.jsonObject(with: self)
            if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
                if JSONSerialization.isValidJSONObject(nestedJson) {
                    let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
                    return try JSONDecoder().decode(D.self, from: nestedJsonData)
                } else {
                    let wrappedJsonObject = ["value": nestedJson]
                    let nestedJsonData = try JSONSerialization.data(withJSONObject: wrappedJsonObject)
                    return try JSONDecoder().decode(DecodableWrapper<D>.self, from: nestedJsonData).value
                }
            } else {
                throw DecodingError.dataCorrupted(.init(
                    codingPath: [],
                    debugDescription: "Nested JSON not found for key path \"\(keyPath)\"")
                )
            }
        } else {
            return try JSONDecoder().decode(D.self, from: self)
        }
    }
    
    private struct DecodableWrapper<T: Decodable>: Decodable {
        let value: T
    }
}
