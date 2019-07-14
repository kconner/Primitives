//
//  PrimitiveSceneViewModel.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PrimitiveSceneViewModel {
    
    private let proximity: ProximityService
    let geometryType: GeometryType
    let material: Driver<Material>
    private let traitCollectionSource = PublishSubject<UITraitCollection>()

    init(
        proximity: ProximityService,
        geometryType: GeometryType,
        material: Driver<Material>
    ) {
        self.proximity = proximity
        self.geometryType = geometryType
        self.material = material
    }

    deinit {
        traitCollectionSource.dispose()
    }
    
    var proximityState: Driver<Bool> {
        proximity.state
    }
    
    func traits(startingWith traits: UITraitCollection) -> Driver<UITraitCollection> {
        traitCollectionSource
            .startWith(traits)
            .asDriver(onErrorJustReturn: traits)
    }
    
    func traitCollectionDidChange(to traits: UITraitCollection) {
        traitCollectionSource.onNext(traits)
    }
    
}
