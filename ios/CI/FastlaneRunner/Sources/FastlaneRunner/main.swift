//
//  Created by Petr Chmelar on 06.02.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Fastlane

class Fastfile: LaneFile {
    // Use in your lane if you need to pass parameters
    func parseInputParameters() -> [String: String] {
        var inputParameters: [String: String] = [:]
        for argument in CommandLine.arguments {
            let splitted = argument.split(separator: ":")
            guard splitted.count > 1 else { continue }
            inputParameters[String(splitted[0])] = String(splitted[1])
        }
        return inputParameters
    }
}

Main().run(with: Fastfile())
