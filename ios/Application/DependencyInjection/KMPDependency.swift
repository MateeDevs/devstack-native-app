//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation
import OSLog
import Utilities

public protocol KMPDependency {
    func get<T: AnyObject>(_ type: T.Type) -> T
    func getProtocol<T: AnyObject>(_ proto: Protocol) -> T
}

public class KMPKoinDependency: KMPDependency {
    
    private var _koin: Koin_coreKoin?
    
    public init() {
        startKoin()
    }
    
    private func startKoin() {
        let onStartup = {
            Logger.app.info("Koin Started")
        }
        
        let koinApplication = KoinIOSKt.doInitKoinIos(doOnStartup: onStartup)
        _koin = koinApplication.koin
    }
    
    public func getProtocol<T: AnyObject>(_ proto: Protocol) -> T {
        _koin?.get(objCProtocol: proto) as! T // swiftlint:disable:this force_cast
    }
    
    public func get<T: AnyObject>(_ type: T.Type) -> T {
        _koin?.get(objCClass: type) as! T // swiftlint:disable:this force_cast
    }
}
