//
//  PrimitiveViewModel.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

final class PrimitiveViewModel {
    
    private let favorites: FavoritesService
    private let settings: SettingsService
    
    let primitive: Primitive
    
    private let proximity = ProximityService()
    
    init(
        favorites: FavoritesService,
        settings: SettingsService,
        primitive: Primitive
    ) {
        self.favorites = favorites
        self.settings = settings
        self.primitive = primitive
    }
    
    var primitiveSceneViewModel: PrimitiveSceneViewModel {
        PrimitiveSceneViewModel(
            proximity: proximity,
            geometryType: primitive.geometryType,
            material: settings.material
        )
    }
    
    var favoriteButtonViewModel: FavoriteButtonViewModel {
        FavoriteButtonViewModel(
            favorites: favorites,
            primitive: primitive
        )
    }
    
    var settingsViewModel: SettingsViewModel {
        SettingsViewModel(settings: settings)
    }
    
    func willAppear() {
        proximity.isEnabled = true
    }
    
    func willDisappear() {
        proximity.isEnabled = false
    }
    
}
