//
//  SettingsService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/25/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import RxSwift
import RxCocoa

final class SettingsService {
    
    private let materialSource = BehaviorSubject<Material>(value: .white)
    private let isPresentingSettingsSource = BehaviorSubject<Bool>(value: false)
    
    deinit {
        materialSource.dispose()
        isPresentingSettingsSource.dispose()
    }

    var material: Driver<Material> {
        materialSource
            .asDriver(onErrorJustReturn: .white)
    }
    
    func setMaterial(_ material: Material) {
        materialSource.onNext(material)
    }
    
    var isPresentingSettings: Driver<Bool> {
        isPresentingSettingsSource
            .asDriver(onErrorJustReturn: false)
    }
    
    func setPresentingSettings(_ isPresentingSettings: Bool) {
        isPresentingSettingsSource.onNext(isPresentingSettings)
    }
    
}
