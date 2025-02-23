//
//  PadScalerTests.swift
//  PadScaler
//
//  Created by Yury Lebedev on 22.02.25.
//

import XCTest
@testable import PadScaler

final class PadScalerTests: XCTestCase {
    var defaultConfiguration: ScalingConfiguration!
    
    override func setUp() {
        super.setUp()
        defaultConfiguration = ScalingConfiguration()
    }
    
    override func tearDown() {
        defaultConfiguration = nil
        super.tearDown()
    }
    
    func testSharedInstanceConfiguration() {
        // Given
        let customConfig = ScalingConfiguration(
            defaultSmallPadMultiplier: 1.8,
            defaultLargePadMultiplier: 2.2,
            defaultPPI: 150
        )
        
        // When
        PadScaler.setSharedConfiguration(customConfig)
        let baseValue: CGFloat = 10
        
        // Then
        let result = baseValue.scaledSize
        XCTAssertNotEqual(result, baseValue * defaultConfiguration.defaultSmallPadMultiplier)
        
        // Reset shared instance
        PadScaler.setSharedConfiguration(.default)
    }
    
    @MainActor
    func testNewInstance() {
        // Given
        let customConfig = ScalingConfiguration(
            defaultSmallPadMultiplier: 1.8,
            defaultLargePadMultiplier: 2.2,
            defaultPPI: 150
        )
        
        // Creating mocks for different device types
        // Now for large iPad
        let padDetector = MockDeviceTypeDetector(isPad: true, isSmallPad: false)
        
        // When
        let padScaler = PadScaler(configuration: customConfig, deviceDetector: padDetector)
        let baseValue: CGFloat = 10
        
        // Then
        let result = padScaler.scaledSize(baseValue)
        XCTAssertEqual(result, baseValue * customConfig.defaultLargePadMultiplier)
        
        // Testing another scenario - for small iPad
        let smallPadDetector = MockDeviceTypeDetector(isPad: true, isSmallPad: true)
        let smallPadScaler = PadScaler(configuration: customConfig, deviceDetector: smallPadDetector)
        let smallPadResult = smallPadScaler.scaledSize(baseValue)
        XCTAssertEqual(smallPadResult, baseValue * customConfig.defaultSmallPadMultiplier)
        
        // And for iPhone
        let phoneDetector = MockDeviceTypeDetector(isPad: false, isSmallPad: false)
        let phoneScaler = PadScaler(configuration: customConfig, deviceDetector: phoneDetector)
        let phoneResult = phoneScaler.scaledSize(baseValue)
        XCTAssertEqual(phoneResult, baseValue) // No multiplier is applied for iPhone
    }
}
