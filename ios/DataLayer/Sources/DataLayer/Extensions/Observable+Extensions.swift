//
//  Created by Petr Chmelar on 03.04.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Foundation
import RxSwift

public extension ObservableType where Element == Data {
    func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil) -> Observable<D> {
        flatMap { Observable.just(try $0.map(type, atKeyPath: keyPath)) }
    }
}
