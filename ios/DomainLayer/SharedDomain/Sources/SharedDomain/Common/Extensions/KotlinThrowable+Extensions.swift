//
//  Created by Tomáš Batěk on 28.04.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import DevstackKmpShared

public extension KotlinThrowable {
    var asError: Swift.Error { KMMError(from: self) }
}
