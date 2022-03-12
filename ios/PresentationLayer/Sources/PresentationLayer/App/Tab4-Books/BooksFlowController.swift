//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import UIKit

class BooksFlowController: FlowController {
    
    override func setup() -> UIViewController {
        let vm = BooksViewModel()
        return BooksViewController.instantiate(fc: self, vm: vm)
    }
}
