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
    static let plane = Primitive(id: .init(), name: "Plane", geometryType: .plane)
    static let box = Primitive(id: .init(), name: "Box", geometryType: .box)
    static let sphere = Primitive(id: .init(), name: "Sphere", geometryType: .sphere)
    static let pyramid = Primitive(id: .init(), name: "Pyramid", geometryType: .pyramid)
    static let cone = Primitive(id: .init(), name: "Cone", geometryType: .cone)
    static let cylinder = Primitive(id: .init(), name: "Cylinder", geometryType: .cylinder)
    static let capsule = Primitive(id: .init(), name: "Capsule", geometryType: .capsule)
    static let tube = Primitive(id: .init(), name: "Tube", geometryType: .tube)
    static let torus = Primitive(id: .init(), name: "Torus", geometryType: .torus)
    
    static let primitives = [plane, box, sphere, pyramid, cone, cylinder, capsule, tube, torus]
    
    static let catalog = Catalog(primitives: primitives)
    
    static let catalogService = CatalogService(value: .success(catalog))
}
#endif
