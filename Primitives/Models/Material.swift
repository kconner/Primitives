//
//  Material.swift
//  Primitives
//
//  Created by Kevin Conner on 6/24/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

enum Material : CaseIterable {
    
    case black
    case white
    case magenta
    case cyan
    
    var name: String {
        switch self {
        case .black:
            return "Black"
        case .white:
            return "White"
        case .magenta:
            return "Magenta"
        case .cyan:
            return "Cyan"
        }
    }
    
}
