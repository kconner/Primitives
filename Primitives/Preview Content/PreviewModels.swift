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
    static let sphere = Primitive(name: "Sphere", geometryType: .sphere)
    static let box = Primitive(name: "Box", geometryType: .box)
    
    static let primitives = [sphere, box]
    
    static let catalog = Catalog(primitives: primitives)
}
#endif
