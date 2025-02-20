//
//  DeviceSizeScaler.swift
//  PadScaler
//
//  Created by Yury Lebedev on 20.02.25.
//  Copyright © 2025 Yury Lebedev. All rights reserved.
//  Licensed under the MIT License. See LICENSE file for details.
//

import Foundation

@MainActor
public protocol DeviceSizeScaling {
    func scaledSize(_ baseValue: CGFloat, customSmallPadMultiplier: CGFloat?, customLargePadMultiplier: CGFloat?) -> CGFloat
    func adaptiveSize(phone: CGFloat, smallPad: CGFloat, largePad: CGFloat) -> CGFloat
}

@MainActor
public final class DeviceSizeScaler: DeviceSizeScaling {
    private let deviceDetector: DeviceTypeDetecting
    private let configuration: ScalingConfiguration
    
    public init(deviceDetector: DeviceTypeDetecting, configuration: ScalingConfiguration) {
        self.deviceDetector = deviceDetector
        self.configuration = configuration
    }
    
    public func scaledSize(_ baseValue: CGFloat, customSmallPadMultiplier: CGFloat? = nil, customLargePadMultiplier: CGFloat? = nil) -> CGFloat {
        let largePadMultiplier = customLargePadMultiplier ?? configuration.defaultLargePadMultiplier
        let smallPadMultiplier = customSmallPadMultiplier ??
            (configuration.defaultSmallPadMultiplier / configuration.defaultLargePadMultiplier) * largePadMultiplier
        
        return deviceDetector.isPad ?
            (deviceDetector.isSmallPad ? baseValue * smallPadMultiplier : baseValue * largePadMultiplier) :
            baseValue
    }
    
    public func adaptiveSize(phone: CGFloat, smallPad: CGFloat, largePad: CGFloat) -> CGFloat {
        deviceDetector.isPad ?
            (deviceDetector.isSmallPad ? smallPad : largePad) :
            phone
    }
}
