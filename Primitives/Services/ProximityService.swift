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
    
    private static var enabledObjectIdentifiers = Set<ObjectIdentifier>() {
        didSet {
            UIDevice.current.isProximityMonitoringEnabled = 0 < enabledObjectIdentifiers.count
        }
    }
    
    var isEnabled = false {
        didSet {
            if isEnabled {
                Self.enabledObjectIdentifiers.insert(id)
            } else {
                Self.enabledObjectIdentifiers.remove(id)
            }
        }
    }
    
    deinit {
        Self.enabledObjectIdentifiers.remove(id)
    }
    
}
