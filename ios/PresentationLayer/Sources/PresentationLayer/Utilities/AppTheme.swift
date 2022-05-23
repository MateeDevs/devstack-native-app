//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit

enum AppTheme {

    /// Defines all the colors used in the app in a semantic way
    enum Colors {
        
        // Main colors
        static let primaryColor = Color(Asset.Colors.mateeYellow.color)
        static let secondaryColor = Color(Asset.Colors.mateeBlue.color)
        
        // Navigation bar
        static let navBarBackground = Color(Asset.Colors.mateeYellow.color)
        static let navBarTitle = Color.white
        
        // Backgrounds
        static let background = Color(UIColor.systemBackground)
        
        // Texts
        static let text = Color(UIColor.label)
        static let headlineText = Color(Asset.Colors.mateeYellow.color)
        
        // Text fields
        static let textFieldTitle = Color(UIColor.systemGray)
        static let textFieldBorder = Color(UIColor.systemGray4)
        
        // Buttons
        static let primaryButtonBackground = Color(Asset.Colors.mateeYellow.color)
        static let primaryButtonTitle = Color.white
        static let secondaryButtonBackground = Color.clear
        static let secondaryButtonTitle = Color(Asset.Colors.mateeYellow.color)
        
        // Indicators
        static let activityIndicator = Color(Asset.Colors.mateeYellow.color)
        
        // Whisper
        static let whisperBackgroundInfo = Color.gray
        static let whisperBackgroundSuccess = Color.green
        static let whisperBackgroundError = Color.red
        static let whisperMessage = Color.white
    }
    
    /// Defines all the fonts used in the app in a semantic way
    enum Fonts {
        
        // Text
        static let headlineText = Font.system(size: 28.0, weight: .medium)
        
        // Text fields
        static let textFieldText = Font.system(size: 17.0, weight: .medium)
        static let textFieldTitle = Font.system(size: 14.0, weight: .regular)
        
        // Buttons
        static let primaryButton = Font.system(size: 20.0, weight: .regular)
        static let secondaryButton = Font.system(size: 20.0, weight: .regular)
        
        // Whisper
        static let whisperMessage = Font.system(size: 13.0, weight: .medium)
        static let whisperMessageUIKit = UIFont.systemFont(ofSize: 13.0, weight: .medium)
    }
}
