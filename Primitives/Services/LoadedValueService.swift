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
    
    private let reloadSource = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    private let load: ((Result<Value, Error>) -> Void) -> Void
    
    init(load: @escaping ((Result<Value, Error>) -> Void) -> Void) {
        self.load = load
        
        valueStorage = .loading
        performLoad()
        
        reloadSource
            .subscribe(onNext: { [weak self] _ in
                self?.reload()
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        valueSource.dispose()
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
    
    var reloadObserver: AnyObserver<Void> {
        reloadSource.asObserver()
    }
    
    // MARK: - Helpers
    
    private func reload() {
        guard case .result = valueStorage else {
            return
        }
        
        valueStorage = .loading
        performLoad()
    }
    
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
