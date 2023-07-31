//
//  Created by Petr Chmelar on 31.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

// Inspiration taken from: https://stackoverflow.com/a/73230965

import Foundation

extension KMPBuildPlugin {
    enum HWArchitecture: String {
        case x86_64
        case arm64
        case undefined
        
        var buildArchitectures: [Arguments.BuildArchitecture] {
            switch self {
            case .x86_64: return [.x86]
            case .arm64: return [.arm64, .arm64sim]
            case .undefined: return [.x86, .arm64, .arm64sim]
            }
        }
    }
    
    var hwArchitecture: HWArchitecture {
        var sysInfo = utsname()
        var finalString: String? = nil
        
        if uname(&sysInfo) == EXIT_SUCCESS {
            let bytes = Data(bytes: &sysInfo.machine, count: Int(_SYS_NAMELEN))
            finalString = String(data: bytes, encoding: .utf8)?.trimmingCharacters(in: CharacterSet(charactersIn: "\0"))
        }
        
        return HWArchitecture(rawValue: finalString ?? "undefined") ?? .undefined
    }
}
