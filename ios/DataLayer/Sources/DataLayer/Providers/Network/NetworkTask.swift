//
//  Created by Petr Chmelar on 03.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation

public enum NetworkTask {
    /// A request with no additional data.
    case requestPlain

    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
