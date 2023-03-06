//
//  Created by David Kadlček on 06.03.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import SwiftUI

public extension EnvironmentValues {
    var isLoading: Bool {
        get { self[LoadingKey.self] }
        set { self[LoadingKey.self] = newValue }
    }
}
