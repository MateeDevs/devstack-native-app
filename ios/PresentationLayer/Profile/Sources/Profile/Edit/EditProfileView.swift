//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct EditProfileView: View {
    
    @ObservedObject private var viewModel: EditProfileViewModel
    
    init(viewModel: EditProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            Text("Editing")
        }
        .padding()
        .lifecycle(viewModel)
        .navigationTitle("Edit")
    }
}

#if DEBUG
import Resolver
import SharedDomainMocks

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCaseMocks()
        
        let vm = EditProfileViewModel(flowController: nil)
        return PreviewGroup {
            EditProfileView(viewModel: vm)
        }
    }
}
#endif
