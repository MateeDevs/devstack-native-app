//
//  Created by Petr Chmelar on 02.08.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import PackagePlugin

@main
struct TwinePlugin: BuildToolPlugin {
    
    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) throws -> [Command] {
        let rootPath = context.package.directory
            .removingLastComponent()
            .removingLastComponent()
        
        return [
            .prebuildCommand(
                displayName: "Run Twine",
                executable: rootPath.appending(["scripts", "twine.sh"]),
                arguments: [],
                environment: [
                  "DERIVED_SOURCES_DIR": context.pluginWorkDirectory
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        ]
    }
}
