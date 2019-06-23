//
//  PreviewModels.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation

#if DEBUG
struct PreviewModels {
    static let sphere = Primitive(name: "Sphere")
    static let cube = Primitive(name: "Cube")
    
    static let primitives = [sphere, cube]
    
    static let catalog = Catalog(primitives: primitives)
}
#endif
