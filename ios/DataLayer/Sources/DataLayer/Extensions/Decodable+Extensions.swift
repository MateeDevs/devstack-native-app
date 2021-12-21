//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation

public extension Decodable {
    static var stub: Data {
        stub(for: String(describing: self))
    }
    
    static var stubList: Data {
        stub(for: "\(String(describing: self))List")
    }
    
    private static func stub(for resourceName: String) -> Data {
        guard let url = Bundle.module.url(forResource: resourceName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
}
