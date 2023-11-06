//
//  Created by Petr Chmelar on 08.02.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Fastlane

extension Fastfile {
    
    func testAlphaLane() {
        testLane(configuration: .alpha)
    }
    
    func testBetaLane() {
        testLane(configuration: .beta)
    }
    
    func testProductionLane() {
        testLane(configuration: .production)
    }
    
    private func testLane(
        configuration: BuildConfiguration
    ) {
        runTests(
            scheme: .userDefined(configuration.scheme),
            xcargs: .userDefined(
                "-skipPackagePluginValidation " +
                "-skipMacroValidation"
            )
        )
    }
}
