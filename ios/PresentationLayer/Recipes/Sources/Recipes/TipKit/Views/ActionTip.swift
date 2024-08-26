//
//  Created by David Kadlček on 24.07.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import TipKit
import UIToolkit

@available(iOS 17, *)
struct ActionTip: Tip {
    
    enum Actions {
        case pop
        case close
        
        var id: String {
            switch self {
            case .pop:
                "pop-screen"
            case .close:
               "close-popup"
            }
        }
    }
    
    var title: Text {
        Text(L10n.recipe_tipkit_action_tip_title)
    }
    
    var actions: [Action] {
        Action(id: Actions.pop.id, title: "Pop screen")
        Action(id: Actions.close.id, title: "Close popup")
    }
}
