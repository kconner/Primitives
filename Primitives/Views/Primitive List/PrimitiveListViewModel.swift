//
//  PrimitiveListViewModel.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import RxCocoa

struct PrimitiveListFilter {
    enum Mode {
        case all
        case favorites
    }
}

final class PrimitiveListViewModel {
    
    private let catalogService: CatalogService
    private let favorites: FavoritesService
    private let settings: SettingsService
  
    private var filterMode = PrimitiveListFilter.Mode.all
    
    init(
        catalog: CatalogService,
        favorites: FavoritesService,
        settings: SettingsService
    ) {
        self.catalogService = catalog
        self.favorites = favorites
        self.settings = settings
    }
    
    var catalog: Driver<Load<Catalog, Error>> {
        catalogService.value
    }
    
    func didTapRefresh() {
        catalogService.reload()
    }

    func didTapSettings() {
        settings.setPresentingSettings(true)
    }
    
}
