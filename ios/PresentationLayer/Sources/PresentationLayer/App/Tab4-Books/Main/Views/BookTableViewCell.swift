//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

import class DevstackKmpShared.Book
import UIKit

class BookTableViewCell: BaseTableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    func setupWithBook(_ book: Book) {
        nameLabel.text = book.name
    }
}
