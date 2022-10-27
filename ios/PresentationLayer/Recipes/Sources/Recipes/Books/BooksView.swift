//
//  Created by Petr Chmelar on 22.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct BooksView: View {

    @ObservedObject private var viewModel: BooksViewModel

    init(viewModel: BooksViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        return VStack {
            if viewModel.state.books.isEmpty && viewModel.state.isLoading {
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
