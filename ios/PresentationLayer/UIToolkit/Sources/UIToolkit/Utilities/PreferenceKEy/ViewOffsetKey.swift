//
//  Created by Tomáš Batěk on 10.07.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
