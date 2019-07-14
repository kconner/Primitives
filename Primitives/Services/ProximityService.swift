//
//  ProximityService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ProximityService {

    let proximityStateDidChange = NotificationCenter.default.rx.notification(UIDevice.proximityStateDidChangeNotification)
        .map { _ in }
    
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
    
    var state: Driver<Bool> {
        proximityStateDidChange
            .startWith(())
            .map { _ in
                UIDevice.current.proximityState
            }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
    }
    
    // MARK: - Helpers

    private var id: ObjectIdentifier {
        return ObjectIdentifier(self)
    }
    
}
