//
//  Created by Julia Jakubcova on 02/08/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Factory
import KMPShared
import SharedDomain

public extension Container {
    // Koin
    private var kmp: Factory<KMPDependency> { self { KMPKoinDependency() }.singleton }
    
    // Sample
    var sampleSharedViewModel: Factory<SampleSharedViewModel> { self { self.kmp().get(SampleSharedViewModel.self) } }
}
