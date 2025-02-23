//
//  ExtensionsTests.swift
//  PadScaler
//
//  Created by Yury Lebedev on 22.02.25.
//

import XCTest
@testable import PadScaler

final class ExtensionsTests: XCTestCase {
    
    @MainActor
    override func setUp() {
        super.setUp()
        let mockDetector = MockDeviceTypeDetector(isPad: true, isSmallPad: true)
        let config = ScalingConfiguration(
            defaultSmallPadMultiplier: 1.6,
            defaultLargePadMultiplier: 2.0,
            defaultPPI: 132
        )
        PadScaler.shared = PadScaler(configuration: config, deviceDetector: mockDetector)
    }
    
    override func tearDown() {
        // Restoring default state
        PadScaler.setSharedConfiguration(.default)
        super.tearDown()
    }
    
    // MARK: - CGFloat Tests
    
    func testCGFloatScaledSize() {
        let value: CGFloat = 10.0
        // Now we know it's a small pad, so multiply by 1.6
        XCTAssertEqual(value.scaledSize, value * 1.6)
    }
    
    func testCGFloatScaledSizeWithMultipliers() {
        let value: CGFloat = 10.0
        let smallPadMultiplier: CGFloat = 1.8
        let largePadMultiplier: CGFloat = 2.2
        
        let expected = value * smallPadMultiplier // Since we have small pad in mock
        XCTAssertEqual(
            value.scaledSize(smallPadMultiplier: smallPadMultiplier, largePadMultiplier: largePadMultiplier),
            expected
        )
    }
    
    func testCGFloatAdaptiveSize() {
        let phone: CGFloat = 10.0
        let smallPad: CGFloat = 20.0
        let largePad: CGFloat = 30.0
        
        XCTAssertEqual(
            phone.adaptiveSize(smallPad: smallPad, largePad: largePad),
            smallPad // Should return smallPad value since mock is configured for small pad
        )
    }
    
    // MARK: - Double Tests
    
    func testDoubleScaledSize() {
        let value: Double = 10.0
        XCTAssertEqual(value.scaledSize, CGFloat(value) * 1.6) // 1.6 is multiplier for small pad
    }
    
    func testDoubleScaledSizeWithMultipliers() {
        let value: Double = 10.0
        let smallPadMultiplier: CGFloat = 1.8
        let largePadMultiplier: CGFloat = 2.2
        
        let expected = CGFloat(value) * smallPadMultiplier // Since we have small pad in mock
        XCTAssertEqual(
            value.scaledSize(smallPadMultiplier: smallPadMultiplier, largePadMultiplier: largePadMultiplier),
            expected
        )
    }
    
    func testDoubleAdaptiveSize() {
        let phone: Double = 10.0
        let smallPad: CGFloat = 20.0
        let largePad: CGFloat = 30.0
        
        XCTAssertEqual(
            phone.adaptiveSize(smallPad: smallPad, largePad: largePad),
            smallPad // Should return smallPad value since mock is configured for small pad
        )
    }
    
    // MARK: - Int Tests
    
    func testIntScaledSize() {
        let value: Int = 10
        XCTAssertEqual(value.scaledSize, CGFloat(value) * 1.6) // 1.6 is multiplier for small pad
    }
    
    func testIntScaledSizeWithMultipliers() {
        let value: Int = 10
        let smallPadMultiplier: CGFloat = 1.8
        let largePadMultiplier: CGFloat = 2.2
        
        let expected = CGFloat(value) * smallPadMultiplier // Since we have small pad in mock
        XCTAssertEqual(
            value.scaledSize(smallPadMultiplier: smallPadMultiplier, largePadMultiplier: largePadMultiplier),
            expected
        )
    }
    
    func testIntAdaptiveSize() {
        let phone: Int = 10
        let smallPad: CGFloat = 20.0
        let largePad: CGFloat = 30.0
        
        XCTAssertEqual(
            phone.adaptiveSize(smallPad: smallPad, largePad: largePad),
            smallPad // Should return smallPad value since mock is configured for small pad
        )
    }
}
