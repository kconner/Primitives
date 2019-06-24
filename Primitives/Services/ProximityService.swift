//
//  ProximityService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI
import Combine

final class ProximityService : BindableObject {

    let didChange = NotificationCenter.default.publisher(for: UIDevice.proximityStateDidChangeNotification)
        .map { _ in }
    
    var state: Bool {
        UIDevice.current.proximityState
    }
    
    private static var instanceCount = 0 {
        didSet {
            UIDevice.current.isProximityMonitoringEnabled = 0 < instanceCount
        }
    }

    init() {
        Self.instanceCount += 1
    }
    
    deinit {
        Self.instanceCount -= 1
    }
    
}
