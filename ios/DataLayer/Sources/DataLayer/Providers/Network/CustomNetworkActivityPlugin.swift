//
//  Created by Petr Chmelar on 23/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import Moya

final class CustomNetworkActivityPlugin: PluginType {
    
    /// Called by the provider as soon as the request is about to start.
    func willSend(_ request: RequestType, target: TargetType) {
    }
    
    /// Called by the provider as soon as a response arrives, even if the request is cancelled.
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case Result.success(_) = result {
            // Hide NoConnectionAlert
        } else {
            // Show NoConnectionAlert
        }
    }
}
