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
    
    private(set) var isFavorite: Driver<Bool>!
    
    init(favorites: FavoritesService, primitive: Primitive) {
        self.favorites = favorites
        self.primitive = primitive
        
        isFavorite = favorites.didChange
            .map { [weak self] _ in
                self?.isFavoriteValue ?? false
            }
            .startWith(self.isFavoriteValue)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
    }
    
    func toggle() {
        favorites[primitive].toggle()
    }
    
    // MARK: - Helpers
    
    private var isFavoriteValue: Bool {
        favorites[primitive]
    }
    
}
