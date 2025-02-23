//
//  ScalingConfigurationTests.swift
//  PadScaler
//
//  Created by Yury Lebedev on 22.02.25.
//

import XCTest
@testable import PadScaler

final class ScalingConfigurationTests: XCTestCase {
    func testDefaultConfiguration() {
        // Given
        let configuration = ScalingConfiguration.default
        
        // Then
        XCTAssertEqual(configuration.defaultSmallPadMultiplier, 1.6)
        XCTAssertEqual(configuration.defaultLargePadMultiplier, 2.0)
        XCTAssertEqual(configuration.defaultPPI, 132)
    }
    
    func testCustomConfiguration() {
        // Given
        let smallPadMultiplier: CGFloat = 1.8
        let largePadMultiplier: CGFloat = 2.2
        let ppi: CGFloat = 150
        
        // When
        let configuration = ScalingConfiguration(
            defaultSmallPadMultiplier: smallPadMultiplier,
            defaultLargePadMultiplier: largePadMultiplier,
            defaultPPI: ppi
        )
        
        // Then
        XCTAssertEqual(configuration.defaultSmallPadMultiplier, smallPadMultiplier)
        XCTAssertEqual(configuration.defaultLargePadMultiplier, largePadMultiplier)
        XCTAssertEqual(configuration.defaultPPI, ppi)
    }
}
