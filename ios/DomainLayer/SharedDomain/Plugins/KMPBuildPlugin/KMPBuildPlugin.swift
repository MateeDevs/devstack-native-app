//
//  Created by Petr Chmelar on 25.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import PackagePlugin

@main
struct KMPBuildPlugin: BuildToolPlugin {
    
    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) throws -> [Command] {
        if ProcessInfo.processInfo.environment["CI"] != nil {
            // Disable this plugin for CI builds
            return []
        } else {
            let rootPath = context.package.directory
                .removingLastComponent()
                .removingLastComponent()
            
            return [
                .prebuildCommand(
                    displayName: "Build KMP",
                    executable: rootPath.appending(["scripts", "build-kmp.sh"]),
                    arguments: Arguments(configuration: .debug, architectures: hwArchitecture.buildArchitectures).dataModel,
                    outputFilesDirectory: context.pluginWorkDirectory
                )
            ]
        }
    }
}
