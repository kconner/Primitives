//
//  FavoritesService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI
import Combine

final class FavoritesService : BindableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    private let userDefaults: UserDefaults

    private static let userDefaultsKey = "favoriteIDs"

    private var favoriteIDs: Set<Primitive.ID> {
        didSet {
            let data = try? PropertyListEncoder().encode(favoriteIDs)
            userDefaults.set(data, forKey: Self.userDefaultsKey)
            
            didChange.send()
        }
    }
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        
        userDefaults.register(defaults: [
            Self.userDefaultsKey: try! PropertyListEncoder().encode(Set<Primitive.ID>())
        ])

        let data = userDefaults.data(forKey: Self.userDefaultsKey)
        if let data = data,
            let favorites = try? PropertyListDecoder().decode(Set<Primitive.ID>.self, from: data)
        {
            self.favoriteIDs = favorites
        } else {
            self.favoriteIDs = []
        }
    }
    
    subscript(_ primitive: Primitive) -> Bool {
        get {
            favoriteIDs.contains(primitive.id)
        }
        set {
            if newValue {
                favoriteIDs.insert(primitive.id)
            } else {
                favoriteIDs.remove(primitive.id)
            }
        }
    }
    
    func toggle(_ primitive: Primitive) {
        favoriteIDs.formSymmetricDifference([primitive.id])
    }

}
