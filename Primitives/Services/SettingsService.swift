//
//  SettingsService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/25/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import RxSwift

final class SettingsService {
    
    let didChange = PublishSubject<Void>()
    
    var material = Material.white {
        didSet {
            didChange.onNext(())
        }
    }
    
    var isPresentingSettings = false {
        didSet {
            didChange.onNext(())
        }
    }
    
    deinit {
        didChange.dispose()
    }
    
}
