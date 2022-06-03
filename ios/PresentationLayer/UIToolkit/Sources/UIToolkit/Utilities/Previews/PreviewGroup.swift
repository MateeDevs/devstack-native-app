//
//  Created by Petr Chmelar on 01.03.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

public struct PreviewGroup<Preview: View>: View {
    
    private let devices: [PreviewDeviceName]
    private let preview: Preview
    
    public init(
        devices: [PreviewDeviceName] = PreviewDeviceName.default,
        @ViewBuilder builder: @escaping () -> Preview
    ) {
        self.devices = devices
        preview = builder()
    }

    public var body: some View {
        Group {
            ForEach(devices, id: \.self) { device in
                preview
                    .previewDevice(PreviewDevice(rawValue: device.rawValue))
                    .previewDisplayName(device.rawValue)
            }
        }
    }
}
