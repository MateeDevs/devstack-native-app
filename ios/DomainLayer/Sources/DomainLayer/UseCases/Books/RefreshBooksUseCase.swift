//
//  Created by Petr Chmelar on 04.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation
import RxSwift

public extension RefreshBooksUseCase {
    func execute(params: Int) -> Observable<Event<Void>> {
        return createObservable(self, params)
    }
}
