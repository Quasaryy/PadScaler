//
//  MockDeviceTypeDetector.swift
//  PadScaler
//
//  Created by Yury Lebedev on 22.02.25.
//

import Foundation
@testable import PadScaler

final class MockDeviceTypeDetector: DeviceTypeDetecting {
    var isPadValue: Bool
    var isSmallPadValue: Bool
    var isCompactDeviceValue: Bool
    
    init(
        isPad: Bool = false,
        isSmallPad: Bool = false,
        isCompactDevice: Bool = true
    ) {
        self.isPadValue = isPad
        self.isSmallPadValue = isSmallPad
        self.isCompactDeviceValue = isCompactDevice
    }
    
    var isPad: Bool { isPadValue }
    var isSmallPad: Bool { isSmallPadValue }
    var isCompactDevice: Bool { isCompactDeviceValue }
    
    var resetCalled = false
    func reset() {
        resetCalled = true
    }
}
