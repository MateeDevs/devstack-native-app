//
//  Created by Julia Jakubcova on 02/08/2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import KMPShared
import SwiftUI

public extension BaseViewModelInt {
    func bindState<S: VmState>(stateBinding: Binding<S>) -> () -> Void {
        @Binding var state: S
        _state = stateBinding
        let coroutineJob = SwiftViewModelCoroutinesKt.subscribeToState(self) { data in
            let value = data as! S
            state = value
        } onComplete: {
            // do nothing
        } onThrow: { _ in
            // do nothing
        }
        return { coroutineJob.cancel(cause: nil) }
    }
}

public extension BaseViewModelInt {
    func asyncStreamFromEvents<E: VmEvent>() -> AsyncStream<E> {
        return AsyncStream<E> { continuation in
            let coroutineJob = SwiftViewModelCoroutinesKt.subscribeToEvents(self) { data in
                let value = data as! E
                continuation.yield(value)
            } onComplete: {
                continuation.finish()
            } onThrow: { _ in
                continuation.finish()
            }
            continuation.onTermination = { _ in
                coroutineJob.cancel(cause: nil)
            }
        }
    }
}


