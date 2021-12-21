//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import FirebaseRemoteConfig
import RxSwift

/// Reactive extensions for FirebaseRemoteConfig
/// - Taken from [RxFirebase](https://github.com/RxSwiftCommunity/RxFirebase)
extension Reactive where Base: RemoteConfig {
    
    /// Fetches Remote Config data
    func fetch() -> Observable<RemoteConfigFetchStatus> {
        return Observable<RemoteConfigFetchStatus>.create { observer in
            self.base.fetch { status, error in
                guard let error = error else {
                    if status == .success {
                        self.base.activate()
                    }
                    observer.onNext(status)
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    /// Fetches Remote Config data and sets a duration that specifies how long config data lasts
    func fetch(withExpirationDuration duration: TimeInterval) -> Observable<RemoteConfigFetchStatus> {
        return Observable<RemoteConfigFetchStatus>.create { observer in
            self.base.fetch(withExpirationDuration: duration) { status, error in
                guard let error = error else {
                    if status == .success {
                        self.base.activate()
                    }
                    observer.onNext(status)
                    observer.onCompleted()
                    return
                }
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
