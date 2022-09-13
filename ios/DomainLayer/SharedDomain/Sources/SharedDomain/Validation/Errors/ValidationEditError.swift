//
//  Created by Adam Penaz on 13.09.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public enum ValidationEditError: Error, Equatable {
    case firstName(FirstName)
    case lastName(LastName)
    case phone(Phone)
    
    public enum FirstName {
        case isEmpty
        case isInvalid
    }
    
    public enum LastName {
        case isEmpty
        case isInvalid
    }
    
    public enum Phone {
        case isEmpty
        case isInvalid
    }
}
