//
//  Created by Patrik Cesnek on 03.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import DomainLayer
import SwiftUI

struct UsersView: View {
    var body: some View {
        List(0 ..< 100) { item in
            Text("User \(item)")
        }
    }
}

struct Users_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
