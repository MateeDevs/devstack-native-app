//
//  Created by Petr Chmelar on 07.02.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Fastlane
import Foundation

extension Fastfile {
    
    func buildAlphaLane() {
        buildLane(configuration: .alpha, apiKey: .matee, keychain: .fastlane)
    }
    
    func buildBetaLane() {
        buildLane(configuration: .beta, apiKey: .matee, keychain: .fastlane)
    }
    
    func buildProductionLane() {
        buildLane(configuration: .production, apiKey: .matee, keychain: .fastlane)
    }
    
    private func buildLane(
        configuration: BuildConfiguration,
        apiKey: AppStoreConnectAPIKey,
        keychain: KeychainConfiguration
    ) {
        // Temporary until 15.3 or higher is default on CI
        xcodes(
            version: "15.3",
            selectForCurrentBuildOnly: true,
            binaryPath: "/usr/local/bin/xcodes"
        )
        
        if FileManager.default.fileExists(atPath: (keychain.path as NSString).expandingTildeInPath) {
            deleteKeychain(name: .userDefined(keychain.name))
        }
        createKeychain(
            name: .userDefined(keychain.name),
            password: keychain.password,
            unlock: true,
            timeout: 3600,
            lockWhenSleeps: true
        )
        importCertificate(
            certificatePath: apiKey.certificatePath,
            keychainName: keychain.name,
            keychainPassword: .userDefined(keychain.password)
        )
        incrementBuildNumber(
            buildNumber: .userDefined(ProcessInfo.processInfo.environment["BUILD_NUMBER"])
        )
        buildIosApp(
            workspace: .userDefined(configuration.workspace),
            scheme: .userDefined(configuration.scheme),
            clean: true,
            outputDirectory: "./ipa",
            outputName: .userDefined(configuration.outputName),
            exportMethod: .userDefined("app-store"),
            archivePath: .userDefined("\(configuration.outputName).xcarchive"),
            xcargs: .userDefined(
                "-skipPackagePluginValidation " +
                "-skipMacroValidation " +
                "-allowProvisioningUpdates " +
                "-authenticationKeyID \(apiKey.id) " +
                "-authenticationKeyIssuerID \(apiKey.issuerId) " +
                "-authenticationKeyPath \(apiKey.path)"
            )
        )
    }
}
