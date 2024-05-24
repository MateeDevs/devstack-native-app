//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation
import OSLog
import Utilities
import VideoToolkit

protocol KMPDependency {
    func get<T: AnyObject>(_ proto: Protocol) -> T
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
        let lightCompressorHelper = LightCompressorHelper()
        
        let koinApplication = KoinIOSKt.doInitKoinIos(
            doOnStartup: onStartup,
            lightCompressorParamsCallback: { params in
                lightCompressorHelper.compress(
                    inputPath: params.inputPath,
                    outputPath: params.outputPath,
                    options: params.options,
                    callback: params.callback
                )
            }
        )
        _koin = koinApplication.koin
    }
    
    func get<T: AnyObject>(_ proto: Protocol) -> T {
        _koin?.get(objCProtocol: proto) as! T // swiftlint:disable:this force_cast
    }
}
