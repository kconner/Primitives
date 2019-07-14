//
//  LoadedValueService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoadedValueService<Value, Error> where Error : Swift.Error {
    
    private let valueSource = PublishSubject<Load<Value, Error>>()
    
    private(set) var valueStorage: Load<Value, Error> {
        didSet {
            valueSource.onNext(valueStorage)
        }
    }

    private let load: ((Result<Value, Error>) -> Void) -> Void
    
    init(load: @escaping ((Result<Value, Error>) -> Void) -> Void) {
        self.load = load
        
        valueStorage = .loading
        performLoad()
    }
    
    deinit {
        valueSource.dispose()
    }
    
    func reload() {
        guard case .result = valueStorage else {
            return
        }
        
        valueStorage = .loading
        performLoad()
    }
    
    var value: Driver<Load<Value, Error>> {
        Observable.concat(
            .deferred { [weak self] in
                .just(self?.valueStorage ?? .loading)
            },
            valueSource
        )
        .asDriver(onErrorJustReturn: .loading)
    }
    
    // MARK: - Helpers
    
    private func performLoad() {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?.load { value in
                DispatchQueue.main.async {
                    self?.valueStorage = .result(value)
                }
            }
        }
    }
    
}
