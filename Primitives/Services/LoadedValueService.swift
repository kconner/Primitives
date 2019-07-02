//
//  LoadedValueService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI
import Combine

class LoadedValueService<Value, Error> : BindableObject where Error : Swift.Error {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    private(set) var value: Load<Value, Error> {
        didSet {
            didChange.send()
        }
    }

    let load: ((Result<Value, Error>) -> Void) -> Void
    
    init(load: @escaping ((Result<Value, Error>) -> Void) -> Void) {
        self.load = load
        
        value = .loading
        performLoad()
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
