//
//  Created by Petr Chmelar on 07.02.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation

struct AppStoreConnectAPIKey {
    let id: String
    let issuerId: String
    let path: String
    let certificatePath: String
}

extension AppStoreConnectAPIKey {
    static let matee = AppStoreConnectAPIKey(
        id: "CQT3ZM53U8",
        issuerId: "e85e5ea1-4316-4e79-a474-858ab98197e0",
        path: "\(FileManager.default.currentDirectoryPath)/AuthKey_Matee.p8",
        certificatePath: "signing/Development_Matee.p12"
    )
}
