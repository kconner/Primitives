//
//  PrimitiveListViewModel.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PrimitiveListViewModel {
    
    private let catalogService: CatalogService
    private let favoritesService: FavoritesService
    private let settingsService: SettingsService
  
    private var filterModeSubject = BehaviorSubject<PrimitiveListFilterMode>(value: .all)
    
    init(
        catalog: CatalogService,
        favorites: FavoritesService,
        settings: SettingsService
    ) {
        self.catalogService = catalog
        self.favoritesService = favorites
        self.settingsService = settings
    }
    
    func primitiveViewModel(for primitive: Primitive) -> PrimitiveViewModel {
        PrimitiveViewModel(
            favorites: favoritesService,
            settings: settingsService,
            primitive: primitive
        )
    }
    
    var settingsViewModel: SettingsViewModel {
        SettingsViewModel(settings: settingsService)
    }
    
    var isLoading: Driver<Bool> {
        catalog
            .map { load in
                load.isLoading
            }
    }
    
    var reload: AnyObserver<Void> {
        catalogService.reload
    }
    
    var filterMode: Driver<PrimitiveListFilterMode> {
        filterModeSubject
            .asDriver(onErrorJustReturn: .all)
    }
    
    var setFilterMode: AnyObserver<PrimitiveListFilterMode> {
        filterModeSubject.asObserver()
    }
    
    var items: Driver<[PrimitiveListItem]> {
        Driver.combineLatest(
            isLoading,
            filterMode,
            filteredPrimitives
        )
        .map { isLoading, filterMode, filteredPrimitives in
            Array(
                [
                    [.filter(filterMode)],
                    
                    filteredPrimitives.map(PrimitiveListItem.primitive),
                    
                    [Self.messageItem(isLoading: isLoading, filterMode: filterMode, filteredPrimitiveCount: filteredPrimitives.count)]
                ].joined()
            )
        }
    }
    
    func isFavorite(_ primitive: Primitive) -> Driver<Bool> {
        favoritesService.isFavorite(primitive)
            .asDriver(onErrorJustReturn: false)
    }
    
    // MARK: - Helpers
    
    private var catalog: Driver<Load<Catalog, Error>> {
        catalogService.value
            .asDriver(onErrorJustReturn: .loading)
    }
    
    private var favoriteIDs: Driver<Set<Primitive.ID>> {
        favoritesService.favoriteIDs
            .asDriver(onErrorJustReturn: [])
    }
    
    private var filteredPrimitives: Driver<[Primitive]> {
        Driver.combineLatest(
            catalog,
            favoriteIDs,
            filterMode
        )
        .map { load, favoriteIDs, filterMode in
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
    
    private static func messageItem(isLoading: Bool, filterMode: PrimitiveListFilterMode, filteredPrimitiveCount: Int) -> PrimitiveListItem {
        if isLoading {
            return .message(NSLocalizedString("Loading…", comment: "Primitives list loading message"))
        } else {
            let countString = String(filteredPrimitiveCount)
            
            let unit: String
            switch filterMode {
            case .all:
                unit = filteredPrimitiveCount == 1
                    ? NSLocalizedString("Primitive", comment: "Primitive list primitive count unit, singular")
                    : NSLocalizedString("Primitives", comment: "Primitive list primitive count unit, plural")
            case .favorites:
                unit = filteredPrimitiveCount == 1
                    ? NSLocalizedString("Favorite", comment: "Primitive list favorite count unit, singular")
                    : NSLocalizedString("Favorites", comment: "Primitive list favorite count unit, plural")
            }
            
            let format = NSLocalizedString("%@ %@", comment: "Primitive list count format")
            
            return .message(String(format: format, countString, unit))
        }
    }
    
}
