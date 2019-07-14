//
//  PrimitiveListFilterMode.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation

enum PrimitiveListFilterMode: Int, CaseIterable {
    
    case all = 0
    case favorites = 1
    
    var title: String {
        switch self {
        case .all:
            return NSLocalizedString("All", comment: "Primitive list filter mode all title")
        case .favorites:
            return NSLocalizedString("Favorites", comment: "Primitive list filter mode favorites title")
        }
    }
    
}
