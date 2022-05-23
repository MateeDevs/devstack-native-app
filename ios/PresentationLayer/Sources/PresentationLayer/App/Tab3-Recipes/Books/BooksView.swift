//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct BooksView: View {
    
    @ObservedObject private var viewModel: BooksViewModel
    
    init(viewModel: BooksViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return VStack {
            if viewModel.state.isLoading {
                PrimaryProgressView()
            } else {
                List {
                    ForEach(viewModel.state.books, id: \.self) { book in
                        HStack {
                            Text(book.name)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .lifecycle(viewModel)
        .navigationTitle(L10n.books_view_toolbar_title)
    }
}

#if DEBUG
import Resolver

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        Resolver.registerUseCasesForPreviews()
        
        let vm = BooksViewModel(flowController: nil)
        return PreviewGroup {
            BooksView(viewModel: vm)
        }
    }
}
#endif
