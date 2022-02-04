//
//  Created by Petr Chmelar on 04.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation
import RxSwift

public extension GetBooksUseCase {
    func execute() -> Observable<[Book]> {
        return createObservable(self).map { (nsArray: NSArray) -> [Book] in
            nsArray as! [Book] // swiftlint:disable:this force_cast
        }
    }
}
