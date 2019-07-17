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
    private let favorites: FavoritesService
    private let settings: SettingsService
  
    private var filterModeSource = BehaviorSubject<PrimitiveListFilterMode>(value: .all)
    
    init(
        catalog: CatalogService,
        favorites: FavoritesService,
        settings: SettingsService
    ) {
        self.catalogService = catalog
        self.favorites = favorites
        self.settings = settings
    }
    
    func primitiveViewModel(for primitive: Primitive) -> PrimitiveViewModel {
        PrimitiveViewModel(
            favorites: favorites,
            settings: settings,
            primitive: primitive
        )
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
    
    var filterMode: Driver<PrimitiveListFilterMode> {
        filterModeSource
            .asDriver(onErrorJustReturn: .all)
    }
    
    var filterModeObserver: AnyObserver<PrimitiveListFilterMode> {
        filterModeSource.asObserver()
    }
    
    var filteredPrimitives: Driver<[Primitive]> {
        Driver.combineLatest(
            catalogService.value,
            favorites.favoriteIDs,
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
        favorites.isFavorite(primitive)
    }
    
    var reload: AnyObserver<Void> {
        catalogService.reloadObserver
    }
    
    // MARK: - Helpers
    
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
