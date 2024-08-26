//
//  Created by David Kadlček on 24.07.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import TipKit
import UIToolkit

@available(iOS 17, *)
struct RuleTip: Tip {
    
    /// Event Rule
    static let remainToShow = Event(id: "number-value")
    
    var title: Text {
        Text(L10n.recipe_tipkit_rule_tip_title)
    }
    
    var message: Text? {
        Text(L10n.recipe_tipkit_rule_tip_message)
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.remainToShow) { $0.donations.count > 2 }
        ]
    }
    
    var options: [any TipOption] = [
        IgnoresDisplayFrequency(true)
    ]
}
