//
//  Created by Petr Chmelar on 31.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

struct Arguments {
    let configuration: BuildConfiguration
    let architectures: [BuildArchitecture]
    
    enum BuildConfiguration: String {
        case debug
        case release
    }

    enum BuildArchitecture: CaseIterable {
        case x86
        case arm64
        case arm64sim
    }
}

extension Arguments {
    var dataModel: [String] {
        [
            configuration.rawValue,
            architectures.contains(.x86).description,
            architectures.contains(.arm64).description,
            architectures.contains(.arm64sim).description
        ]
    }
}
