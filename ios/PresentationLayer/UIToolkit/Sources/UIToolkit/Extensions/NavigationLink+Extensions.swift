//
//  Created by Petr Chmelar on 29.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

// Taken from: https://stackoverflow.com/a/66891173

public extension NavigationLink where Label == EmptyView, Destination == EmptyView {

   /// Useful in cases where a `NavigationLink` is needed but there should not be a destination. e.g. for programmatic navigation.
   static var empty: NavigationLink {
       self.init(destination: EmptyView(), label: { EmptyView() })
   }
}
