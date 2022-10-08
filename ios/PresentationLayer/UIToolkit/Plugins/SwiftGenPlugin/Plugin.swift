//
//  Created by Petr Chmelar on 08.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import PackagePlugin

@main
struct SwiftGenPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let configurations: [Path] = [context.package.directory, target.directory]
            .map { $0.appending("swiftgen.yml") }
            .filter { FileManager.default.fileExists(atPath: $0.string) }
        
        return try configurations.map { configuration in
            return Command.prebuildCommand(
                displayName: "SwiftGen",
                executable: try context.tool(named: "swiftgen").path,
                arguments: [
                    "config",
                    "run",
                    "--verbose",
                    "--config", "\(configuration)"
                ],
                environment: [
                    "PROJECT_DIR": context.package.directory,
                    "TARGET_NAME": target.name,
                    "PRODUCT_MODULE_NAME": (target as? SourceModuleTarget)?.moduleName ?? "",
                    "DERIVED_SOURCES_DIR": context.pluginWorkDirectory
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        }
    }
}
