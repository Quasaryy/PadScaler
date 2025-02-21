//
//  CGFloat+Ext.swift
//  PadScaler
//
//  Created by Yury Lebedev on 20.02.25.
//  Copyright © 2025 Yury Lebedev. All rights reserved.
//  Licensed under the MIT License. See LICENSE file for details.
//

import Foundation

public extension CGFloat {
    func adaptiveSize(smallPad: CGFloat, largePad: CGFloat) -> CGFloat {
        PadScaler.shared.adaptiveSize(phone: self, smallPad: smallPad, largePad: largePad)
    }
    
    var scaledSize: CGFloat {
        PadScaler.shared.scaledSize(self)
    }
    
    func scaledSize(smallPadMultiplier: CGFloat? = nil, largePadMultiplier: CGFloat? = nil) -> CGFloat {
        PadScaler.shared.scaledSize(self, customSmallPadMultiplier: smallPadMultiplier, customLargePadMultiplier: largePadMultiplier)
    }
}
