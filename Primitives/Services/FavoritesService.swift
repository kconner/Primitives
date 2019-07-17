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
    
    private let favoriteIDsSource = BehaviorSubject<Set<Primitive.ID>>(value: [])
    
    private let userDefaults: UserDefaults

    private static let userDefaultsKey = "favoriteIDs"

    private var favoriteIDsStorage: Set<Primitive.ID> = [] {
        didSet {
            let data = try? PropertyListEncoder().encode(favoriteIDsStorage)
            userDefaults.set(data, forKey: Self.userDefaultsKey)

            favoriteIDsSource.onNext(favoriteIDsStorage)
        }
    }
    
    private let toggleSource = PublishSubject<Primitive.ID>()
    private let disposeBag = DisposeBag()
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        
        userDefaults.register(defaults: [
            Self.userDefaultsKey: try! PropertyListEncoder().encode(Set<Primitive.ID>())
        ])

        let data = userDefaults.data(forKey: Self.userDefaultsKey)
        if let data = data,
            let favorites = try? PropertyListDecoder().decode(Set<Primitive.ID>.self, from: data)
        {
            self.favoriteIDsStorage = favorites
            favoriteIDsSource.onNext(favoriteIDsStorage)
        }
        
        toggleSource
            .subscribe(onNext: { [weak self] primitiveID in
                self?.favoriteIDsStorage.formSymmetricDifference([primitiveID])
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        favoriteIDsSource.dispose()
    }
    
    var favoriteIDs: Driver<Set<Primitive.ID>> {
        favoriteIDsSource
            .asDriver(onErrorJustReturn: [])
    }
    
    func isFavorite(_ primitive: Primitive) -> Driver<Bool> {
        favoriteIDs
            .map { favoriteIDs in
                favoriteIDs.contains(primitive.id)
            }
    }
    
    func toggleObserver(_ primitive: Primitive) -> AnyObserver<Void> {
        toggleSource
            .mapObserver { _ in
                primitive.id
            }
    }

}
