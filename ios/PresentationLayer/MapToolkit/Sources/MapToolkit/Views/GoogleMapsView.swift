//
//  Created by Petr Chmelar on 03.08.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import GoogleMaps
import SwiftUI
import UIToolkit
import Utilities

public struct GoogleMapsView: UIViewRepresentable {
    
    public init() {
        // Provide GoogleMaps API key
        GMSServices.provideAPIKey(NetworkingConstants.googleMapsAPIKey)
    }
    
    public func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView(frame: .zero)
        return mapView
    }
    
    public func updateUIView(_ uiView: GMSMapView, context: Context) {}
}
