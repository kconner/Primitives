//
//  FavoritesService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class FavoritesService {
    
    private static let userDefaultsKey = "favoriteIDs"

    private let favoriteIDsSubject = BehaviorSubject<Set<Primitive.ID>>(value: [])
    private let disposeBag = DisposeBag()

    init(userDefaults: UserDefaults = .standard) {
        // Register initial values of user defaults.
        userDefaults.register(defaults: [
            Self.userDefaultsKey: try! PropertyListEncoder().encode(Set<Primitive.ID>())
        ])

        // Try to load from user defaults.
        let data = userDefaults.data(forKey: Self.userDefaultsKey)
        if let data = data,
            let favoriteIDs = try? PropertyListDecoder().decode(Set<Primitive.ID>.self, from: data)
        {
            favoriteIDsSubject.onNext(favoriteIDs)
        }
        
        // When we emit a new copy of favorites, persist it to user defaults.
        favoriteIDsSubject
            .subscribe(onNext: { (favoriteIDs) in
                let data = try? PropertyListEncoder().encode(favoriteIDs)
                userDefaults.set(data, forKey: Self.userDefaultsKey)
            })
            .disposed(by: disposeBag)
    }
    
    var favoriteIDs: Driver<Set<Primitive.ID>> {
        favoriteIDsSubject
            .asDriver(onErrorJustReturn: [])
    }
    
    func isFavorite(_ primitive: Primitive) -> Driver<Bool> {
        favoriteIDs
            .map { favoriteIDs in
                favoriteIDs.contains(primitive.id)
            }
    }
    
    func toggleFavorite(_ primitive: Primitive) -> AnyObserver<Void> {
        // Sending an event to this observer toggles the primitive's favorite state
        // and emits a new complete value of the favorites set
        favoriteIDsSubject
            .mapObserver { [weak self] _ in
                ((try? self?.favoriteIDsSubject.value()) ?? []).symmetricDifference([primitive.id])
            }
    }

}
