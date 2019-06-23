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
    static let lightNodeName = "light"

    let geometryType: GeometryType
    let allowsCameraControl: Bool
    
    @ObjectBinding var proximityStateService = ProximityStateService()
    
    func makeUIView(context: UIViewRepresentableContext<PrimitiveSceneView>) -> SCNView {
        let sceneView = SCNView()
        
        guard let scene = SCNScene(named: "primitive.scn") else {
            assertionFailure("Expected a scene")
            return sceneView
        }
        
        sceneView.scene = scene
        sceneView.allowsCameraControl = allowsCameraControl
        scene.isPaused = !allowsCameraControl
        
        return sceneView
    }
    
    func updateUIView(_ sceneView: SCNView, context: UIViewRepresentableContext<PrimitiveSceneView>) {
        guard let scene = sceneView.scene,
            let primitiveNode = scene.rootNode.childNode(withName: Self.primitiveNodeName, recursively: false),
            let lightNode = scene.rootNode.childNode(withName: Self.lightNodeName, recursively: true) else
        {
            assertionFailure("Expected a scene with a primitive node and a light node")
            return
        }

        Self.updateBackgroundColor(in: scene, for: sceneView.traitCollection)
        Self.updateGeometry(in: primitiveNode, to: geometryType)
        Self.updateLight(in: lightNode, forProximityState: proximityStateService.currentValue)
    }
    
    private static func updateBackgroundColor(in scene: SCNScene, for traitCollection: UITraitCollection) {
        let backgroundColor = UIColor.systemBackground.resolvedColor(with: traitCollection)
        scene.background.contents = backgroundColor
    }

    private static func updateGeometry(in primitiveNode: SCNNode, to geometryType: GeometryType) {
        let oldGeometry = primitiveNode.geometry
        let newGeometry = geometry(for: geometryType)

        // Preserve the material as defined in the scene
        newGeometry.materials = oldGeometry?.materials ?? []
        
        primitiveNode.geometry = newGeometry
    }
    
    private static func geometry(for type: GeometryType) -> SCNGeometry {
        switch type {
        case .plane:
            return SCNPlane()
        case .box:
            return SCNBox()
        case .sphere:
            return SCNSphere()
        case .pyramid:
            return SCNPyramid()
        case .cone:
            return SCNCone()
        case .cylinder:
            return SCNCylinder()
        case .capsule:
            return SCNCapsule()
        case .tube:
            return SCNTube()
        case .torus:
            return SCNTorus()
        }
    }
    
    private static func updateLight(in lightNode: SCNNode, forProximityState proximityState: Bool) {
        lightNode.isHidden = proximityState
    }

}

#if DEBUG
struct PrimitiveSceneView_Previews : PreviewProvider {
    static var previews: some View {
        PrimitiveSceneView(geometryType: .box, allowsCameraControl: true)
    }
}
#endif
