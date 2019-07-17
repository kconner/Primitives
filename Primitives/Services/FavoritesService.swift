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
    
    private let favoriteIDsSubject = BehaviorSubject<Set<Primitive.ID>>(value: [])

    private static let userDefaultsKey = "favoriteIDs"

    private let disposeBag = DisposeBag()
    
    init(userDefaults: UserDefaults = .standard) {
        userDefaults.register(defaults: [
            Self.userDefaultsKey: try! PropertyListEncoder().encode(Set<Primitive.ID>())
        ])

        let data = userDefaults.data(forKey: Self.userDefaultsKey)
        if let data = data,
            let favoriteIDs = try? PropertyListDecoder().decode(Set<Primitive.ID>.self, from: data)
        {
            favoriteIDsSubject.onNext(favoriteIDs)
        }
        
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
        favoriteIDsSubject
            .mapObserver { [weak self] _ in
                ((try? self?.favoriteIDsSubject.value()) ?? []).symmetricDifference([primitive.id])
            }
    }

}
