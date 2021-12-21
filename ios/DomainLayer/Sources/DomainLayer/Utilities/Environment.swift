//
//  Created by Petr Chmelar on 08.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public enum EnvironmentType {
    case alpha
    case beta
    case production
}

public enum EnvironmentFlavor {
    case debug
    case release
}

public struct Environment {
    public static var type: EnvironmentType = .alpha
    public static var flavor: EnvironmentFlavor = .debug
}
