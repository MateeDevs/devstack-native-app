//
//  Created by Julia Jakubcova on 23/05/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import DependencyInjection
import DevstackKmpShared
import Factory
import SharedDomain
import SwiftUI
import UIToolkit
import PhotosUI

final class VideosViewModel: BaseViewModel, ViewModel, ObservableObject, ImagePickerViewControllerDelegate {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.compressVideoUseCase) private(set) var compressVideoUseCase
    
    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()
    
    struct State {
        var progress: Int = 0
        var videoResults: [CompressionResult] = []
    }
    
    // MARK: Intent
    enum Intent {
    case pickVideo
        case loadVideo(videoUrl: NSURL)
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .loadVideo(let videoUrl): await compressVideo(videoUrl)
            case .pickVideo: pickVideo()
            }
        })
    }
    
    // MARK: Private
    
    private func pickVideo() {
        flowController?.handleFlow(VideosFlow.pickMedia(mediaURL: { media in self.mediaSelected(mediaURL: media) }))
    }
    
    func mediaSelected(mediaURL: NSURL?) {
        print(mediaURL ?? "nothing")
        if let url = mediaURL {
            Task {
                await compressVideo(url)
            }
        }
    }
    
    private func compressVideo(_ videoUrl: NSURL) async {
        let settings: [(options: VideoCompressOptions, library: VideoCompressLibrary)] = [
            (VideoCompressOptions(
                bitrate: nil,
                frameRate: nil,
                trim: nil,
                maximumSize: KotlinPair(first: 1920, second: 1080),
                audioBitrate: nil,
                audioSampleRate: nil
            ), VideoCompressLibrary.avfoundation),
            (VideoCompressOptions(
                bitrate: nil,
                frameRate: nil,
                trim: nil,
                maximumSize: nil,
                audioBitrate: nil,
                audioSampleRate: nil
            ), VideoCompressLibrary.avfoundation),
            (VideoCompressOptions(
                bitrate: 2_500_000,
                frameRate: nil,
                trim: nil,
                maximumSize: KotlinPair(first: 1920, second: 1080),
                audioBitrate: nil,
                audioSampleRate: nil
            ), VideoCompressLibrary.lightcompressor),
            (VideoCompressOptions(
                bitrate: nil,
                frameRate: nil,
                trim: nil,
                maximumSize: nil,
                audioBitrate: nil,
                audioSampleRate: nil
            ), VideoCompressLibrary.lightcompressor)
        ]
        
        for (options, library) in settings {
            let path = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let newPath = path.appendingPathComponent("\(UUID.init().uuidString)-\(options)-\(library).mp4")
            
            let startTime = Date.now
            
            for try await result: VideoCompressResult in compressVideoUseCase.execute(
                params: CompressVideoUseCaseParams(
                    inputPath: videoUrl as URL,
                    outputPath: newPath,
                    options: options,
                    library: library
                )
            ) {
                if let completion = result as? VideoCompressResultCompletion {
                    if let success = completion.result as? ResultSuccess {
                        let outputUrl = success.data
                        state.videoResults.append(
                            CompressionResult(
                                options: options,
                                library: library,
                                durationToCompress: Date.now.timeIntervalSince(startTime),
                                inputLength: videoUrl.fileSize,
                                outputLength: outputUrl.fileSize,
                                resultUrl: outputUrl
                            )
                        )
                    } else if let error = completion.result as? ResultError {
                        print(error.error.message ?? "")
                    }
                } else if let progressResult = result as? VideoCompressResultProgress {
                    state.progress = progressResult.progress.int
                }
            }
        }
    }
}

extension NSURL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            if let path = self.path {
                return try FileManager.default.attributesOfItem(atPath: path)
            }
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}

extension UInt64 {
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .file)
    }
}

class CompressionResult {
    
    let options: VideoCompressOptions
    let library: VideoCompressLibrary
    let durationToCompress: TimeInterval
    let inputLength: UInt64
    let outputLength: UInt64
    let resultUrl: NSURL
    
    init(
        options: VideoCompressOptions,
        library: VideoCompressLibrary,
        durationToCompress: TimeInterval,
        inputLength: UInt64,
        outputLength: UInt64,
        resultUrl: NSURL
    ) {
        self.options = options
        self.library = library
        self.durationToCompress = durationToCompress
        self.inputLength = inputLength
        self.outputLength = outputLength
        self.resultUrl = resultUrl
    }
    
    var compressionRation: Double { Double(self.inputLength) / Double(self.outputLength) }
    var spaceSaving: Double { 1 - (Double(self.outputLength) / Double(self.inputLength)) }
}
