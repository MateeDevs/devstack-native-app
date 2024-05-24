//
//  Created by Julia Jakubcova on 24/05/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import DevstackKmpShared
import Foundation
import LightCompressor

public class LightCompressorHelper {
    
    private let videoCompressor: LightCompressor
    
    public init() {
        self.videoCompressor = LightCompressor()
    }
    
    public func compress(inputPath: URL, outputPath: URL, options: VideoCompressOptions, callback: @escaping (VideoCompressResult) -> Void) {
        let videoBitrate: Int? = if let bitrate = options.bitrate {
            Int(truncating: bitrate) / 1_000_000
        } else {
            nil
        }
        let resolution: CGSize? = if let size = options.maximumSize, let width = size.first, let height = size.second {
            CGSize(width: CGFloat(truncating: width), height: CGFloat(truncating: height))
        } else {
            nil
        }
        
        let compression = videoCompressor.compressVideo(
            videos: [
                .init(
                    source: inputPath,
                    destination: outputPath,
                    configuration: .init(
                        quality: VideoQuality.medium,
                        videoBitrateInMbps: videoBitrate,
                        disableAudio: false,
                        keepOriginalResolution: resolution == nil,
                        videoSize: resolution
                    )
                )
            ],
            progressQueue: .main,
            progressHandler: { progress in
                DispatchQueue.main.async {
                    callback(VideoCompressResultProgress(progress: Int32(progress.fractionCompleted * 100)))
                }
            },
            completion: {[weak self] result in
                guard let `self` = self else { return }
                
                switch result {
                case .onSuccess( _, let path): callback(VideoCompressResultCompletion(result: ResultSuccess(data: path as NSURL)))
                case .onStart: do {}
                case .onFailure(_, _): callback(VideoCompressResultCompletion(result: ResultError(error: CommonError.UnknownError(), data: nil)))
                case .onCancelled: callback(VideoCompressResultCompletion(result: ResultError(error: CommonError.UnknownError(), data: nil)))
                }
            })
    }
}
