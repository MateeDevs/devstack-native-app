//
//  Created by Julia Jakubcova on 23/05/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import SwiftUI

struct VideosView: View {
    
    @ObservedObject private var viewModel: VideosViewModel
    
    init(viewModel: VideosViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Button("Pick video") {
                    viewModel.onIntent(.pickVideo)
                }
                .padding()
                
                Divider()
                
                ForEach(viewModel.state.videoResults, id: \.resultUrl) { result in
                    item(result: result)
                }
                
                if viewModel.state.progress > 0 && viewModel.state.progress < 100 {
                    ProgressView(value: Double(viewModel.state.progress), total: 100)
                }
            }
        }
    }
    
    func item(result: CompressionResult) -> some View {
        VStack {
            Text("Library: \(result.library.name)")
            Text("Options: \(result.options)")
            Text("Duration: \(result.durationToCompress.formatted())")
            Text("Ratio: \(result.compressionRation)")
            Text("Saving: \(result.spaceSaving)")
            Text("Input: \(result.inputLength.fileSizeString)")
            Text("Output: \(result.outputLength.fileSizeString)")
            Divider()
        }
    }
}

#if DEBUG
#Preview {
    let vm = VideosViewModel(flowController: nil)
    return VideosView(viewModel: vm)
}
#endif
