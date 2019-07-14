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
    
    deinit {
        materialSource.dispose()
    }

    var material: Driver<Material> {
        materialSource
            .asDriver(onErrorJustReturn: .white)
    }
    
    func setMaterial(_ material: Material) {
        materialSource.onNext(material)
    }

}
