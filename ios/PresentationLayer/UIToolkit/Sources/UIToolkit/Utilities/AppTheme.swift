//
//  Created by Petr Chmelar on 28/01/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import SwiftUI
import UIKit

public enum AppTheme {

    /// Defines all the colors used in the app in a semantic way
    public enum Colors {
        
        // Main colors
        public static let primaryColor = Asset.Colors.mateeYellow.color
        public static let secondaryColor = Asset.Colors.mateeBlue.color
        
        // Navigation bar
        public static let navBarBackground = Asset.Colors.mateeYellow.color
        public static let navBarTitle = Color.white
        
        // Backgrounds
        public static let background = Color(UIColor.systemBackground)
        
        // Texts
        public static let text = Color(UIColor.label)
        public static let headlineText = Asset.Colors.mateeYellow.color
        
        // Text fields
        public static let textFieldTitle = Color(UIColor.systemGray)
        public static let textFieldBorder = Color(UIColor.systemGray4)
        
        // Buttons
        public static let primaryButtonBackground = Asset.Colors.mateeYellow.color
        public static let primaryButtonTitle = Color.white
        public static let secondaryButtonBackground = Color.clear
        public static let secondaryButtonTitle = Asset.Colors.mateeYellow.color
        
        // ProgressView
        public static let progressView = Asset.Colors.mateeYellow.color
        
        // Whisper
        public static let whisperBackgroundInfo = Color.gray
        public static let whisperBackgroundSuccess = Color.green
        public static let whisperBackgroundError = Color.red
        public static let whisperMessage = Color.white
        
        // Toast
        public static let toastSuccessColor = Asset.Colors.success.color
        public static let toastErrorColor = Asset.Colors.error.color
        public static let toastInfoColor = Asset.Colors.info.color
    }
    
    /// Defines all the fonts used in the app in a semantic way
    public enum Fonts {
        
        // Text
        public static let headlineText = Font.system(size: 28.0, weight: .medium)
        
        // Text fields
        public static let textFieldText = Font.system(size: 17.0, weight: .medium)
        public static let textFieldTitle = Font.system(size: 14.0, weight: .regular)
        
        // Buttons
        public static let primaryButton = Font.system(size: 20.0, weight: .regular)
        public static let secondaryButton = Font.system(size: 20.0, weight: .regular)
        
        // Whisper
        public static let whisperMessage = Font.system(size: 13.0, weight: .medium)
        public static let whisperMessageUIKit = UIFont.systemFont(ofSize: 13.0, weight: .medium)
    }
}
