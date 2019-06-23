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

    private static let userDefaultsKey = "favorites"

    var favorites: Set<Primitive> {
        didSet {
            let data = try? PropertyListEncoder().encode(favorites)
            userDefaults.set(data, forKey: Self.userDefaultsKey)
            
            didChange.send()
        }
    }
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        
        userDefaults.register(defaults: [
            Self.userDefaultsKey: try! PropertyListEncoder().encode(Set<Primitive>())
        ])

        let data = userDefaults.data(forKey: Self.userDefaultsKey)
        if let data = data,
            let favorites = try? PropertyListDecoder().decode(Set<Primitive>.self, from: data)
        {
            self.favorites = favorites
        } else {
            self.favorites = []
        }
    }

}
