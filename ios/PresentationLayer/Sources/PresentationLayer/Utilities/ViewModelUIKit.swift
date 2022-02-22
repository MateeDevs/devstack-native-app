//
//  Created by Petr Chmelar on 17/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

protocol ViewModelUIKit {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
