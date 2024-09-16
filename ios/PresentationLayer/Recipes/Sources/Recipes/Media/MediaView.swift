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
        ZStack {
            if !viewModel.state.media.isEmpty {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text(L10n.recipes_media_title)
                            .font(AppTheme.Fonts.headlineText)
                            .foregroundStyle(AppTheme.Colors.headlineText)
                            .padding([.leading, .top])
                        
                        VStack(spacing: 16) {
                            ForEach(viewModel.state.media, id: \.self) { media in
                                switch media {
                                case .photo(let photo, _):
                                    Image(uiImage: photo)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.rect(cornerRadius: 10))
                                        .padding(.horizontal)
                                }
                            }
                            
                            Spacer()
                                .frame(height: 16)
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                
                HStack(spacing: 0) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(AppTheme.Colors.secondaryButtonTitle)
                        .padding(.leading)
                    
                    Button(L10n.recipes_media_add_media) {
                        viewModel.onIntent(.addMedia)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
                .background(
                    Capsule()
                        .fill(.white)
                        .clipped()
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
                )
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(16)
            }
        }
    }
}

#if DEBUG
#Preview {
    MediaView(viewModel: .init(flowController: nil))
}
#endif
