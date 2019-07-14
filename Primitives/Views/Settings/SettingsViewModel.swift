//
//  SettingsViewModel.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import RxCocoa

final class SettingsViewModel {
    
    private let settings: SettingsService
    
    init(settings: SettingsService) {
        self.settings = settings
    }
    
    var material: Driver<Material> {
        settings.material
    }
    
    func setMaterial(_ material: Material) {
        settings.setMaterial(material)
    }
    
}
