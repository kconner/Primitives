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
    static let plane = Primitive(name: "Plane", geometryType: .plane)
    static let box = Primitive(name: "Box", geometryType: .box)
    static let sphere = Primitive(name: "Sphere", geometryType: .sphere)
    static let pyramid = Primitive(name: "Pyramid", geometryType: .pyramid)
    static let cone = Primitive(name: "Cone", geometryType: .cone)
    static let cylinder = Primitive(name: "Cylinder", geometryType: .cylinder)
    static let capsule = Primitive(name: "Capsule", geometryType: .capsule)
    static let tube = Primitive(name: "Tube", geometryType: .tube)
    static let torus = Primitive(name: "Torus", geometryType: .torus)
    
    static let primitives = [plane, box, sphere, pyramid, cone, cylinder, capsule, tube, torus]
    
    static let catalog = Catalog(primitives: primitives)
    
    static let catalogService = CatalogService(catalog: .loaded(catalog))
}
#endif
