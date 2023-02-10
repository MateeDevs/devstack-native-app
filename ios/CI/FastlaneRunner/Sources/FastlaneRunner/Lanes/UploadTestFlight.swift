//
//  Created by Petr Chmelar on 07.02.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Fastlane
import Foundation

extension Fastfile {
    
    func uploadTestFlightAlphaLane() {
        uploadTestFlightLane(configuration: .alpha, apiKey: .matee)
    }
    
    func uploadTestFlightBetaLane() {
        uploadTestFlightLane(configuration: .beta, apiKey: .matee)
    }
    
    func uploadTestFlightProductionLane() {
        uploadTestFlightLane(configuration: .production, apiKey: .matee)
    }
    
    private func uploadTestFlightLane(
        configuration: BuildConfiguration,
        apiKey: AppStoreConnectAPIKey
    ) {
        let distributeExternal = ProcessInfo.processInfo.environment["DISTRIBUTE_EXTERNAL"] == "true"
        let version = getIpaInfoPlistValue(key: "CFBundleShortVersionString", ipa: "./ipa/\(configuration.outputName).ipa")
        let build = getIpaInfoPlistValue(key: "CFBundleVersion", ipa: "./ipa/\(configuration.outputName).ipa")
        
        appStoreConnectApiKey(
            keyId: apiKey.id,
            issuerId: apiKey.issuerId,
            keyContent: .userDefined(ProcessInfo.processInfo.environment["APP_STORE_CONNECT_API_KEY_CONTENT"]),
            inHouse: false
        )
        uploadToTestflight(
            appIdentifier: .userDefined(configuration.appIdentifier),
            ipa: "./ipa/\(configuration.outputName).ipa",
            changelog: .userDefined(distributeExternal ? "\(configuration.outputName) \(version) build \(build)" : nil),
            skipWaitingForBuildProcessing: .userDefined(!distributeExternal),
            distributeExternal: .userDefined(distributeExternal),
            groups: .userDefined(configuration.testFlightGroups)
        )
        if distributeExternal {
            slack(
                message: "[iOS \(configuration.outputName)] \(version) build \(build) uploaded to the TestFlight\nLink: \(configuration.testFlightLink)",
                channel: .userDefined(configuration.slackChannel),
                slackUrl: ProcessInfo.processInfo.environment["SLACK_URL"] ?? "",
                payload: [:],
                defaultPayloads: []
            )
        }
    }
}
