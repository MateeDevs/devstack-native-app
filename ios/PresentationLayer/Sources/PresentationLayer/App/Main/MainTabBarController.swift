//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

enum MainTab: Int {
    case users = 0
    case profile = 1
    case counter = 2
    case books = 3
}

class MainTabBarController: UITabBarController {
    
    static func instantiate() -> MainTabBarController {
        StoryboardScene.Main.initialScene.instantiate()
    }

}
