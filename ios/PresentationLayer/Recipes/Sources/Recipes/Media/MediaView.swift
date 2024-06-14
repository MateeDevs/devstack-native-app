//
//  Created by Krystof Prihoda on 18.04.2024.
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI
import UIToolkit

struct MediaView: View {
    
    @ObservedObject private var viewModel: MediaViewModel
    
    init(
        viewModel: MediaViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if viewModel.state.media.isEmpty {
            Button(L10n.recipes_media_add_media) {
                viewModel.onIntent(.addMedia)
            }
            .buttonStyle(SecondaryButtonStyle())
        } else {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text(L10n.recipes_media_title)
                        .font(AppTheme.Fonts.headlineText)
                        .foregroundStyle(AppTheme.Colors.headlineText)
                        .padding([.leading, .top])
                    
                    VStack(spacing: 16) {
                        ForEach(viewModel.state.media, id: \.self) { media in
                            switch media {
                            case .photo(let photo):
                                Image(uiImage: photo)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 10))
                                    .padding(.horizontal)
                            default:
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray)
                                    .frame(width: .infinity)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 16)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    MediaView(viewModel: .init(flowController: nil))
}
#endif
