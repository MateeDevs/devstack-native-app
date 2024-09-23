//
//  Created by Julia Jakubcova on 23/09/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import DevstackKmpShared

#warning("TODO: Remove this workaround when issue [https://github.com/icerockdev/moko-resources/issues/714] is resolved")
public func fixMokoResourcesForTests() {
    if ProcessInfo.processInfo.processName == "xctest" {
        MokoResourcesPreviewWorkaroundKt.nsBundle = Bundle.init(for: KotlinBase.self)
    }
}

#warning("TODO: Remove this workaround when issue [https://github.com/icerockdev/moko-resources/issues/714] is resolved")
public func fixMokoResourcesForPreviews() {
    if ProcessInfo.processInfo.processName == "XCPreviewAgent" {
        MokoResourcesPreviewWorkaroundKt.nsBundle = Bundle.init(for: KotlinBase.self)
    }
}
