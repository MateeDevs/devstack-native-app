//
//  Created by Petr Chmelar on 28.02.2022
//  Copyright © 2022 Matee. All rights reserved.
//

enum PreviewDeviceName: String {
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhone12 = "iPhone 12"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"
    case iPhone12Mini = "iPhone 12 mini"
    case iPhone13 = "iPhone 13"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iPhone13Mini = "iPhone 13 mini"
    case iPhoneSE = "iPhone SE (2nd generation)"
    case iPodTouch = "iPod touch (7th generation)"
    
    case iPad = "iPad (9th generation)"
    case iPadAir = "iPad Air (4th generation)"
    case iPadPro_9_7inch = "iPad Pro (9.7-inch)"
    case iPadPro_11inch = "iPad Pro (11-inch) (3rd generation)"
    case iPadPro_12_9inch = "iPad Pro (12.9-inch) (5th generation)"
    case iPadMini = "iPad mini (6th generation)"
    
    case appleTV = "Apple TV"
    case appleTV_4k = "Apple TV 4K (2nd generation)"
    case appleTV_4k_1080p = "Apple TV 4K (at 1080p) (2nd generation)"
    
    case watch5_40mm = "Apple Watch Series 5 - 40mm"
    case watch5_44mm = "Apple Watch Series 5 - 44mm"
    case watch6_44mm = "Apple Watch Series 6 - 44mm"
    case watch7_41mm = "Apple Watch Series 7 - 41mm"
    case watch7_45mm = "Apple Watch Series 7 - 45mm"
    
    static let `default`: [PreviewDeviceName] = [.iPhone13Pro, .iPhoneSE]
}
