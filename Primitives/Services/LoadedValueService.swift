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
    
    private let valueSubject = BehaviorSubject<Load<Value, Error>>(value: .loading)
    private let disposeBag = DisposeBag()

    init(load: @escaping ((Result<Value, Error>) -> Void) -> Void) {
        let valueSubject = self.valueSubject
        
        // When the load value changes to loading, begin loading.
        valueSubject
            .map { load in load.isLoading }
            .distinctUntilChanged()
            .filter { isLoading in isLoading }
            .subscribe(onNext: { _ in
                // Include an artifical delay during loading.
                DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
                    load { value in
                        DispatchQueue.main.async {
                            // After loading, emit the result value.
                            valueSubject.onNext(.result(value))
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    var value: Driver<Load<Value, Error>> {
        valueSubject
            .asDriver(onErrorJustReturn: .loading)
    }
    
    var reloadObserver: AnyObserver<Void> {
        // Sending an event to this observer stores a load value of .loading,
        // which triggers a load if we were not already loading.
        valueSubject
            .mapObserver { _ in .loading }
    }
    
}
