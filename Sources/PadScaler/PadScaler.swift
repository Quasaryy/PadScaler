//
//  PadScaler.swift
//  PadScaler
//
//  Created by Yury Lebedev on 20.02.25.
//  Copyright © 2025 Yury Lebedev. All rights reserved.
//  Licensed under the MIT License. See LICENSE file for details.
//

import Foundation

public final class PadScaler {
    internal static var shared = PadScaler(configuration: .default)
    
    private var configuration: ScalingConfiguration
    private var sizeScaler: DeviceSizeScaling
    
    private init(configuration: ScalingConfiguration) {
        self.configuration = configuration
        
        let (isPad, isSmallPad) = MainActor.assumeIsolated {
            let detector = DeviceTypeDetector(configuration: configuration)
            return (detector.isPad, detector.isSmallPad)
        }
        
        self.sizeScaler = DeviceSizeScaler(isPad: isPad, isSmallPad: isSmallPad, configuration: configuration)
    }
    
    // MARK: - Public API
    public func scaledSize(_ baseValue: CGFloat, customSmallPadMultiplier: CGFloat? = nil, customLargePadMultiplier: CGFloat? = nil) -> CGFloat {
        sizeScaler.scaledSize(baseValue, customSmallPadMultiplier: customSmallPadMultiplier, customLargePadMultiplier: customLargePadMultiplier)
    }
    
    public func adaptiveSize(phone: CGFloat, smallPad: CGFloat, largePad: CGFloat) -> CGFloat {
        sizeScaler.adaptiveSize(phone: phone, smallPad: smallPad, largePad: largePad)
    }
    
    public static func setSharedConfiguration(_ config: ScalingConfiguration) {
        shared = PadScaler(configuration: config)
    }
    
    public static func newInstance(_ config: ScalingConfiguration) -> PadScaler {
        PadScaler(configuration: config)
    }
    
}

// MARK: - Global Functions
public func adaptiveSize(phone: CGFloat, smallPad: CGFloat, largePad: CGFloat) -> CGFloat {
    PadScaler.shared.adaptiveSize(phone: phone, smallPad: smallPad, largePad: largePad)
}
