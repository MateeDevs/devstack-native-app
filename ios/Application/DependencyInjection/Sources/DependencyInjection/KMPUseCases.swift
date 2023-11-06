//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import DevstackKmpShared
import Factory
import SharedDomain

public extension Container {
    // Koin
    private var kmp: Factory<KMPDependency> { self { KMPKoinDependency() }}
    
    // Books
    var getBooksUseCase: Factory<GetBooksUseCase> { self { self.kmp().getProtocol(GetBooksUseCase.self) } }
    var refreshBooksUseCase: Factory<RefreshBooksUseCase> { self { self.kmp().getProtocol(RefreshBooksUseCase.self) } }
}
