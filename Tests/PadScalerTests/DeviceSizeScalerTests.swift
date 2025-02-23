//
//  DeviceSizeScalerTests.swift
//  PadScaler
//
//  Created by Yury Lebedev on 22.02.25.
//

import XCTest
@testable import PadScaler

final class DeviceSizeScalerTests: XCTestCase {
    var configuration: ScalingConfiguration!
    
    override func setUp() {
        super.setUp()
        configuration = ScalingConfiguration(
            defaultSmallPadMultiplier: 1.6,
            defaultLargePadMultiplier: 2.0,
            defaultPPI: 132
        )
    }
    
    override func tearDown() {
        configuration = nil
        super.tearDown()
    }
    
    func testScaledSizeForPhone() {
        // Given
        let scaler = DeviceSizeScaler(isPad: false, isSmallPad: false, configuration: configuration)
        let baseValue: CGFloat = 10
        
        // When
        let result = scaler.scaledSize(baseValue)
        
        // Then
        XCTAssertEqual(result, baseValue)
    }
    
    func testScaledSizeForSmallPad() {
        // Given
        let scaler = DeviceSizeScaler(isPad: true, isSmallPad: true, configuration: configuration)
        let baseValue: CGFloat = 10
        
        // When
        let result = scaler.scaledSize(baseValue)
        
        // Then
        XCTAssertEqual(result, baseValue * configuration.defaultSmallPadMultiplier)
    }
    
    func testScaledSizeForLargePad() {
        // Given
        let scaler = DeviceSizeScaler(isPad: true, isSmallPad: false, configuration: configuration)
        let baseValue: CGFloat = 10
        
        // When
        let result = scaler.scaledSize(baseValue)
        
        // Then
        XCTAssertEqual(result, baseValue * configuration.defaultLargePadMultiplier)
    }
    
    func testScaledSizeWithCustomMultipliers() {
        // Given
        let scaler = DeviceSizeScaler(isPad: true, isSmallPad: true, configuration: configuration)
        let baseValue: CGFloat = 10
        let customSmallPadMultiplier: CGFloat = 1.8
        let customLargePadMultiplier: CGFloat = 2.2
        
        // When
        let result = scaler.scaledSize(
            baseValue,
            customSmallPadMultiplier: customSmallPadMultiplier,
            customLargePadMultiplier: customLargePadMultiplier
        )
        
        // Then
        XCTAssertEqual(result, baseValue * customSmallPadMultiplier)
    }
    
    func testAdaptiveSize() {
        // Test cases
        let testCases = [
            (isPad: false, isSmallPad: false, expected: 10.0), // Phone
            (isPad: true, isSmallPad: true, expected: 20.0),   // Small Pad
            (isPad: true, isSmallPad: false, expected: 30.0)   // Large Pad
        ]
        
        for testCase in testCases {
            // Given
            let scaler = DeviceSizeScaler(
                isPad: testCase.isPad,
                isSmallPad: testCase.isSmallPad,
                configuration: configuration
            )
            
            // When
            let result = scaler.adaptiveSize(phone: 10, smallPad: 20, largePad: 30)
            
            // Then
            XCTAssertEqual(
                result,
                testCase.expected,
                "Failed for isPad: \(testCase.isPad), isSmallPad: \(testCase.isSmallPad)"
            )
        }
    }
    
    func testAdaptiveSizeWithNegativeValues() {
        // Arrange
        let scaler = DeviceSizeScaler(isPad: true, isSmallPad: true, configuration: .default)
        
        // Act
        let result = scaler.adaptiveSize(phone: -10, smallPad: -20, largePad: -30)
        
        // Assert
        XCTAssertEqual(result, -20, "Should return a negative value for smallPad")
        
        // Arrange
        let largeScaler = DeviceSizeScaler(isPad: true, isSmallPad: false, configuration: .default)
        
        // Act
        let largeResult = largeScaler.adaptiveSize(phone: -10, smallPad: -20, largePad: -30)
        
        // Assert
        XCTAssertEqual(largeResult, -30, "Should return a negative value for largePad")
    }
}
