//
//  SettingsViewModel.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import RxSwift
import RxCocoa

final class SettingsViewModel {
    
    private let settings: SettingsService
    
    init(settings: SettingsService) {
        self.settings = settings
    }
    
    var material: Driver<Material> {
        settings.material
            .asDriver(onErrorJustReturn: .white)
    }
    
    func setMaterial(_ material: Material) -> AnyObserver<Void> {
        settings.material
            .mapObserver { _ in material }
    }

    
}
