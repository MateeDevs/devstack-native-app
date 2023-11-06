//
//  Created by Petr Chmelar on 28.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

public enum PreviewDeviceName: String {
    case iPhone15 = "iPhone 15"
    case iPhone15Plus = "iPhone 15 Plus"
    case iPhone15Pro = "iPhone 15 Pro"
    case iPhone15ProMax = "iPhone 15 Pro Max"
    case iPhoneSE = "iPhone SE (3rd generation)"
    
    case iPad = "iPad (10th generation)"
    case iPadAir = "iPad Air (5th generation)"
    case iPadPro_11inch = "iPad Pro (11-inch) (4rd generation)"
    case iPadPro_12_9inch = "iPad Pro (12.9-inch) (6th generation)"
    case iPadMini = "iPad mini (6th generation)"
    
    case appleTV = "Apple TV"
    case appleTV_4k = "Apple TV 4K (2nd generation)"
    case appleTV_4k_1080p = "Apple TV 4K (at 1080p) (2nd generation)"
    
    case watch5_40mm = "Apple Watch Series 5 - 40mm"
    case watch5_44mm = "Apple Watch Series 5 - 44mm"
    case watch6_44mm = "Apple Watch Series 6 - 44mm"
    case watch7_41mm = "Apple Watch Series 7 - 41mm"
    case watch7_45mm = "Apple Watch Series 7 - 45mm"
    
    public static let `default`: [PreviewDeviceName] = [.iPhone15Pro, .iPhoneSE]
}
