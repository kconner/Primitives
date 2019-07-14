//
//  PrimitiveListViewModel.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import RxSwift
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
  
    private var filterModeSource = BehaviorSubject<PrimitiveListFilter.Mode>(value: .all)
    
    init(
        catalog: CatalogService,
        favorites: FavoritesService,
        settings: SettingsService
    ) {
        self.catalogService = catalog
        self.favorites = favorites
        self.settings = settings
    }
    
    var settingsViewModel: SettingsViewModel {
        SettingsViewModel(settings: settings)
    }
    
    var isLoading: Driver<Bool> {
        catalogService.value
            .map { load in
                load.isLoading
            }
    }
    
    var filterMode: Driver<PrimitiveListFilter.Mode> {
        filterModeSource
            .asDriver(onErrorJustReturn: .all)
    }
    
    var filteredPrimitives: Driver<[Primitive]> {
        Driver.combineLatest(
            catalogService.value,
            favorites.favoriteIDs,
            filterMode
        )
        .map { (load, favoriteIDs, filterMode) in
            let primitives = load.valueIfLoaded?.primitives ?? []
                
            switch filterMode {
            case .all:
                return primitives
            case .favorites:
                return primitives.filter { primitive in
                    favoriteIDs.contains(primitive.id)
                }
            }
        }
    }
    
    func didTapRefresh() {
        catalogService.reload()
    }
    
}
