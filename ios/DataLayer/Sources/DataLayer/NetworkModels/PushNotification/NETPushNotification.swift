//
//  Created by Petr Chmelar on 17.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

struct NETPushNotification: Decodable {
    let aps: APS
    let type: String
    let entity_id: String
    
    struct APS: Decodable {
        let alert: APSAlert
    }

    struct APSAlert: Decodable {
        let title: String
        let body: String
    }
}

// Conversion from NetworkModel to DomainModel
extension NETPushNotification: DomainRepresentable {
    typealias DomainModel = PushNotification
    
    var domainModel: DomainModel {
        PushNotification(
            title: aps.alert.title,
            body: aps.alert.body,
            type: PushNotificationType(rawValue: Int(type) ?? 1) ?? .info,
            entityId: entity_id
        )
    }
}
