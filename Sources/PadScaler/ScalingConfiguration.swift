//
//  ScalingConfiguration.swift
//  PadScaler
//
//  Created by Yury Lebedev on 20.02.25.
//  Copyright © 2025 Yury Lebedev. All rights reserved.
//  Licensed under the MIT License. See LICENSE file for details.
//

import Foundation

public struct ScalingConfiguration: Sendable {
    public var defaultSmallPadMultiplier: CGFloat
    public var defaultLargePadMultiplier: CGFloat
    public var defaultPPI: CGFloat
    
    public init(
        defaultSmallPadMultiplier: CGFloat = 1.6,
        defaultLargePadMultiplier: CGFloat = 2.0,
        defaultPPI: CGFloat = 132
    ) {
        self.defaultSmallPadMultiplier = defaultSmallPadMultiplier
        self.defaultLargePadMultiplier = defaultLargePadMultiplier
        self.defaultPPI = defaultPPI
    }
    
    public static let `default` = ScalingConfiguration()
}
