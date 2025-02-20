//
//  Double+Ext.swift
//  PadScaler
//
//  Created by Yury Lebedev on 20.02.25.
//  Copyright © 2025 Yury Lebedev. All rights reserved.
//  Licensed under the MIT License. See LICENSE file for details.
//

import Foundation

@MainActor
public extension Double {
    func adaptiveSize(smallPad: CGFloat, largePad: CGFloat) -> CGFloat {
        CGFloat(self).adaptiveSize(smallPad: smallPad, largePad: largePad)
    }
    
    var scaledSize: CGFloat {
        CGFloat(self).scaledSize
    }
    
    func scaledSize(smallPadMultiplier: CGFloat? = nil, largePadMultiplier: CGFloat? = nil) -> CGFloat {
        CGFloat(self).scaledSize(smallPadMultiplier: smallPadMultiplier, largePadMultiplier: largePadMultiplier)
    }
}
