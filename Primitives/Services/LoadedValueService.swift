//
//  LoadedValueService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation
import RxSwift

class LoadedValueService<Value, Error> where Error : Swift.Error {
    
    let didChange = PublishSubject<Void>()
    
    private(set) var value: Load<Value, Error> {
        didSet {
            didChange.onNext(())
        }
    }

    let load: ((Result<Value, Error>) -> Void) -> Void
    
    init(load: @escaping ((Result<Value, Error>) -> Void) -> Void) {
        self.load = load
        
        value = .loading
        performLoad()
    }
    
    deinit {
        didChange.dispose()
    }
    
    func reload() {
        guard case .result = value else {
            return
        }
        
        value = .loading
        performLoad()
    }
    
    // MARK: - Helpers
    
    private func performLoad() {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?.load { value in
                DispatchQueue.main.async {
                    self?.value = .result(value)
                }
            }
        }
    }
    
}
