//
//  DeviceTypeDetector.swift
//  PadScaler
//
//  Created by Yury Lebedev on 20.02.25.
//  Copyright © 2025 Yury Lebedev. All rights reserved.
//  Licensed under the MIT License. See LICENSE file for details.
//

import UIKit

@MainActor
public protocol DeviceTypeDetecting {
    var isPad: Bool { get }
    var isSmallPad: Bool { get }
    var isCompactDevice: Bool { get }
    func reset()
}

@MainActor
public final class DeviceTypeDetector: DeviceTypeDetecting {
    private let configuration: ScalingConfiguration
    private var _isSmallPad: Bool?
    
    public init(configuration: ScalingConfiguration) {
        self.configuration = configuration
    }
    
    public var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public var isCompactDevice: Bool {
        !isPad || isSmallPad
    }
    
    public var isSmallPad: Bool {
        if let cached = _isSmallPad { return cached }
        let value = calculateIsSmallPad()
        _isSmallPad = value
        return value
    }
    
    private func calculateIsSmallPad() -> Bool {
        let screenSize = UIScreen.main.nativeBounds
        let scale = UIScreen.main.nativeScale
        guard scale != 0 else { return false }
        
        let screenDiagonalPixels = sqrt(pow(screenSize.width, 2) + pow(screenSize.height, 2))
        let screenDiagonalPoints = screenDiagonalPixels / scale
        let screenDiagonalInches = screenDiagonalPoints / configuration.defaultPPI
        return screenDiagonalInches < 12.9
    }
    
    public func reset() {
        _isSmallPad = nil
    }
}
