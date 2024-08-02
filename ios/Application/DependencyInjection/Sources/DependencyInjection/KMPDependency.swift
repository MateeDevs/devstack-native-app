//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import KMPShared
import Foundation
import OSLog
import Utilities

protocol KMPDependency {
    func getProtocol<T: AnyObject>(_ proto: Protocol) -> T
    func get<T: AnyObject>(_ type: T.Type) -> T
    func get<T: AnyObject>(_ type: T.Type, parameter: Any) -> T
}

final class KMPKoinDependency: KMPDependency {
    
    private var _koin: Koin_coreKoin?
    
    init() {
        startKoin()
    }
    
    private func startKoin() {
        let onStartup = {
            Logger.app.info("Koin Started")
        }
        
        let koinApplication = KoinIOSKt.doInitKoinIos(doOnStartup: onStartup)
        _koin = koinApplication.koin
    }
    
    func getProtocol<T: AnyObject>(_ proto: Protocol) -> T {
        _koin?.get(objCProtocol: proto) as! T // swiftlint:disable:this force_cast
    }
    
    func get<T: AnyObject>(_ type: T.Type) -> T {
        _koin?.get(objCClass: type) as! T // swiftlint:disable:this force_cast
    }
    
    func get<T: AnyObject>(_ type: T.Type, parameter: Any) -> T {
        _koin?.get(objCClass: type, parameter: parameter) as! T // swiftlint:disable:this force_cast
    }
}
