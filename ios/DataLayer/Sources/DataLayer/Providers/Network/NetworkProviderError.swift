//
//  Created by Petr Chmelar on 13.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public enum NetworkProviderError: Error {
    case requestFailed(statusCode: NetworkStatusCode, message: String)
}
