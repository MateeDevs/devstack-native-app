//
//  Created by David Kadlček on 24.07.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import TipKit
import UIToolkit

@available(iOS 17, *)
struct PopoverTip: Tip {
    
    var title: Text {
        Text(L10n.recipe_tipkit_popover_tip_title)
    }
    
    var message: Text? {
        Text(L10n.recipe_tipkit_popover_tip_message)
    }
    
    var image: Image? {
        Asset.Images.brandLogo.image
    }
    
    var options: [any TipOption] {
        [Tips.MaxDisplayCount(1)]
    }
}
