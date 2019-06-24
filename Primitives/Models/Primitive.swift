//
//  Primitive.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation

struct Primitive : Codable, Equatable, Hashable {
    typealias ID = UUID
    
    var id: ID
    var name: String
    var geometryType: GeometryType
}
