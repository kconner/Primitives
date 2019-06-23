//
//  PrimitiveSceneView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI
import SceneKit

struct PrimitiveSceneView : UIViewRepresentable {
    
    static let primitiveNodeName = "primitive"
    static let primitiveMaterialName = "primitive"

    var geometryType: GeometryType
    
    func makeUIView(context: UIViewRepresentableContext<PrimitiveSceneView>) -> SCNView {
        let uiView = SCNView()
        
        uiView.scene = SCNScene(named: "primitive.scn")
        uiView.allowsCameraControl = true
        
        return uiView
    }
    
    func updateUIView(_ uiView: SCNView, context: UIViewRepresentableContext<PrimitiveSceneView>) {
        guard let scene = uiView.scene,
            let primitiveNode = scene.rootNode.childNode(withName: PrimitiveSceneView.primitiveNodeName, recursively: false) else
        {
            assertionFailure("Expected a scene with a primitive node.")
            return
        }
        
        let material = primitiveNode.geometry?.material(named: PrimitiveSceneView.primitiveMaterialName)

        switch geometryType {
        case .plane:
            primitiveNode.geometry = SCNPlane()
        case .box:
            primitiveNode.geometry = SCNBox()
        case .sphere:
            primitiveNode.geometry = SCNSphere()
        case .pyramid:
            primitiveNode.geometry = SCNPyramid()
        case .cone:
            primitiveNode.geometry = SCNCone()
        case .cylinder:
            primitiveNode.geometry = SCNCylinder()
        case .capsule:
            primitiveNode.geometry = SCNCapsule()
        case .tube:
            primitiveNode.geometry = SCNTube()
        case .torus:
            primitiveNode.geometry = SCNTorus()
        }
        
        primitiveNode.geometry?.firstMaterial = material
    }

}

#if DEBUG
struct PrimitiveSceneView_Previews : PreviewProvider {
    static var previews: some View {
        PrimitiveSceneView(geometryType: .box)
    }
}
#endif
