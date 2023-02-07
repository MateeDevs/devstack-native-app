//
//  Created by Petr Chmelar on 08.02.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Fastlane

extension Fastfile {
    
    func tagAlphaLane() {
        tagLane(configuration: .alpha)
    }
    
    func tagBetaLane() {
        tagLane(configuration: .beta)
    }
    
    func tagProductionLane() {
        tagLane(configuration: .production)
    }
    
    private func tagLane(
        configuration: BuildConfiguration
    ) {
        let version = getIpaInfoPlistValue(key: "CFBundleShortVersionString", ipa: "./ipa/\(configuration.outputName).ipa")
        let build = getIpaInfoPlistValue(key: "CFBundleVersion", ipa: "./ipa/\(configuration.outputName).ipa")
        addGitTag(tag: "ios/\(version).\(build)")
        pushGitTags(tag: "ios/\(version).\(build)")
    }
}
