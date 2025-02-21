//
//  DeviceSizeScaler.swift
//  PadScaler
//
//  Created by Yury Lebedev on 20.02.25.
//  Copyright © 2025 Yury Lebedev. All rights reserved.
//  Licensed under the MIT License. See LICENSE file for details.
//

import Foundation

public protocol DeviceSizeScaling {
    func scaledSize(_ baseValue: CGFloat, customSmallPadMultiplier: CGFloat?, customLargePadMultiplier: CGFloat?) -> CGFloat
    func adaptiveSize(phone: CGFloat, smallPad: CGFloat, largePad: CGFloat) -> CGFloat
}

public final class DeviceSizeScaler: DeviceSizeScaling {
    private let isPad: Bool
    private let isSmallPad: Bool
    private let configuration: ScalingConfiguration
    
    public init(isPad: Bool, isSmallPad: Bool, configuration: ScalingConfiguration) {
        self.isPad = isPad
        self.isSmallPad = isSmallPad
        self.configuration = configuration
    }
    
    public func scaledSize(_ baseValue: CGFloat, customSmallPadMultiplier: CGFloat? = nil, customLargePadMultiplier: CGFloat? = nil) -> CGFloat {
        let largePadMultiplier = customLargePadMultiplier ?? configuration.defaultLargePadMultiplier
        let smallPadMultiplier = customSmallPadMultiplier ??
            (configuration.defaultSmallPadMultiplier / configuration.defaultLargePadMultiplier) * largePadMultiplier
        
        return isPad ?
            (isSmallPad ? baseValue * smallPadMultiplier : baseValue * largePadMultiplier) :
            baseValue
    }
    
    public func adaptiveSize(phone: CGFloat, smallPad: CGFloat, largePad: CGFloat) -> CGFloat {
        isPad ?
            (isSmallPad ? smallPad : largePad) :
            phone
    }
}
