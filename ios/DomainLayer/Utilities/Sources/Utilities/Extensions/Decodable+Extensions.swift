//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation

public extension Decodable {
    static func stub(in bundle: Bundle) -> Data {
        stub(for: bundle.url(forResource: String(describing: self), withExtension: "json"))
    }
    
    static func stubList(in bundle: Bundle) -> Data {
        stub(for: bundle.url(forResource: "\(String(describing: self))List", withExtension: "json"))
    }
    
    private static func stub(for url: URL?) -> Data {
        guard let url, let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
}
