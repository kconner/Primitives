//
//  PrimitiveSceneView.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import SceneKit
import RxSwift

final class PrimitiveSceneView : SCNView {
    
    static let primitiveNodeName = "primitive"
    static let primitiveMaterialName = "primitive"
    static let lightNodeName = "light"
    
    private var viewModel: PrimitiveSceneViewModel!
    private let disposeBag = DisposeBag()
    
    func configure(with viewModel: PrimitiveSceneViewModel) {
        self.viewModel = viewModel
        
        guard let scene = SCNScene(named: "primitive.scn"),
            let primitiveNode = scene.rootNode.childNode(withName: Self.primitiveNodeName, recursively: false),
            let lightNode = scene.rootNode.childNode(withName: Self.lightNodeName, recursively: true) else
        {
            assertionFailure("Expected a scene with a primitive node and a light node")
            return
        }

        self.scene = scene
        allowsCameraControl = true
        isAccessibilityElement = true
        accessibilityTraits = .image
        
        Self.updateGeometry(in: primitiveNode, to: viewModel.geometryType)
        Self.addRotationAnimation(to: primitiveNode)
        
        viewModel.material
            .drive(onNext: { [weak self] material in
                PrimitiveSceneView.updateMaterial(in: primitiveNode, with: material)
                self?.accessibilityLabel = "\(viewModel.material) \(viewModel.geometryType)"
            })
            .disposed(by: disposeBag)
        
        viewModel.proximityState
            .drive(onNext: { proximityState in
                PrimitiveSceneView.updateLight(in: lightNode, forProximityState: proximityState)
            })
            .disposed(by: disposeBag)
        
        viewModel.traits(startingWith: traitCollection)
            .drive(onNext: { traits in
                Self.updateBackgroundColor(in: scene, for: traits)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UIView
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        viewModel?.traitCollectionDidChange(to: traitCollection)
    }
    
    // MARK: - Helpers
    
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
    
    private static func addRotationAnimation(to primitiveNode: SCNNode) {
        let rotationAnimation = CABasicAnimation(keyPath: "rotation")
        rotationAnimation.fromValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0.1, w: 0))
        rotationAnimation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0.1, w: 2 * .pi))
        rotationAnimation.duration = 10
        rotationAnimation.repeatCount = .greatestFiniteMagnitude
        primitiveNode.addAnimation(rotationAnimation, forKey: nil)
    }
    
    private static func updateBackgroundColor(in scene: SCNScene, for traitCollection: UITraitCollection) {
        let backgroundColor = UIColor.systemBackground.resolvedColor(with: traitCollection)
        scene.background.contents = backgroundColor
    }
    
    private static func updateMaterial(in primitiveNode: SCNNode, with material: Material) {
        primitiveNode.geometry?.materials.first?.diffuse.contents = material.color
    }
    
    private static func updateLight(in lightNode: SCNNode, forProximityState proximityState: Bool) {
        lightNode.isHidden = proximityState
    }
    
}

private extension Material {
    
    var color: UIColor {
        switch self {
        case .black:
            return .init(white: 0.25, alpha: 1.0)
        case .white:
            return .init(white: 0.9, alpha: 1.0)
        case .magenta:
            return .init(hue: 0.833, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        case .cyan:
            return .init(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
    }
    
}
