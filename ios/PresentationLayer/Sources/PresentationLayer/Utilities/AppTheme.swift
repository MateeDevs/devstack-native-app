//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

enum AppTheme {

    /// Defines all the colors used in the app in a semantic way
    enum Colors {
        
        // Main colors
        static let primaryColor = Asset.Colors.mateeYellow.color
        static let secondaryColor = Asset.Colors.mateeBlue.color
        
        // Navigation bar
        static let navBarBackground = Asset.Colors.mateeYellow.color
        static let navBarTitle = UIColor.white
        
        // Backgrounds
        static let background = UIColorCompatible.systemBackground
        
        // Separators
        static let separator = UIColorCompatible.separator
        
        // Labels
        static let label = UIColorCompatible.label
        static let headlineLabel = Asset.Colors.mateeYellow.color
        
        // Text fields
        static let textFieldTitle = UIColor.systemGray
        static let textFieldBorder = UIColorCompatible.systemGray4
        
        // Placeholders
        static let placeholder = UIColorCompatible.placeholderText
        
        // Buttons
        static let primaryButtonBackground = Asset.Colors.mateeYellow.color
        static let primaryButtonTitle = UIColor.white
        
        static let secondaryButtonBackground = UIColor.clear
        static let secondaryButtonTitle = Asset.Colors.mateeYellow.color
        
        // Indicators
        static let activityIndicator = Asset.Colors.mateeYellow.color
        
        // Alerts
        static let alertBackgroundInfo = UIColor.systemGray
        static let alertBackgroundSuccess = UIColor.systemGreen
        static let alertBackgroundError = UIColor.systemRed
        static let alertMessage = UIColor.white
    }
    
    /// Defines all the fonts used in the app in a semantic way
    enum Fonts {
        
        // Labels
        static let headlineLabel = UIFont.systemFont(ofSize: 28.0, weight: .medium)
        
        // Text fields
        static let textFieldText = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        static let textFieldTitle = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        static let textFieldHint = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        
        // Buttons
        static let primaryButton = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        
        // Alerts
        static let alertMessage = UIFont.systemFont(ofSize: 13.0, weight: .medium)
    }
}
