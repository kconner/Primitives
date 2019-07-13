//
//  FavoriteButtonViewModel.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import RxCocoa

final class FavoriteButtonViewModel {
    
    private let favorites: FavoritesService
    private let primitive: Primitive
    
    init(favorites: FavoritesService, primitive: Primitive) {
        self.favorites = favorites
        self.primitive = primitive
    }
    
    var isFavorite: Driver<Bool> {
        favorites.isFavorite(primitive)
    }
    
    func toggle() {
        favorites[primitive].toggle()
    }

}
