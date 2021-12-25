//
//  Created by Jan Kusy on 17.03.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

// swiftlint:disable implicitly_unwrapped_optional

import DevstackKmpShared

public protocol HasGetBooksUseCase {
    var getBooksUseCase: GetBooksUseCase! { get }
}

public protocol HasRefreshBooksUseCase {
    var refreshBooksUseCase: RefreshBooksUseCase! { get }
}
