//
//  Created by Petr Chmelar on 30.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation

extension Bundle {
    /// Workaround for crashing SwiftUI Previews when any of underlying modules uses .module
    /// Taken from: https://developer.apple.com/forums/thread/664295
    static var myModule: Bundle = {
        /* The name of your local package, prepended by "LocalPackages_" for iOS and "PackageName_" for macOS. You may have same PackageName and TargetName*/
        let bundleNameIOS = "LocalPackages_UIToolkit"
        let bundleNameMacOs = "UIToolkit_UIToolkit"
        let candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,
            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: BundleToken.self).resourceURL,
            /* For command-line tools. */
            Bundle.main.bundleURL,
            /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
            Bundle(for: BundleToken.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
            Bundle(for: BundleToken.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent()
        ]
        
        for candidate in candidates {
            let bundlePathiOS = candidate?.appendingPathComponent(bundleNameIOS + ".bundle")
            let bundlePathMacOS = candidate?.appendingPathComponent(bundleNameMacOs + ".bundle")
            if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
                return bundle
            } else if let bundle = bundlePathMacOS.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle")
    }()
}

private final class BundleToken {}
