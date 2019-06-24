//
//  LoadService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI
import Combine

class LoadService<Value> : BindableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    private(set) var value: Load<Value> {
        didSet {
            didChange.send()
        }
    }
    
    let load: ((Load<Value>) -> Void) -> Void
    
    init(load: @escaping ((Load<Value>) -> Void) -> Void) {
        self.load = load
        
        value = .loading
        performLoad()
    }
    
    func reload() {
        guard !value.isLoading else {
            return
        }
        
        value = .loading
        performLoad()
    }
    
    // MARK: - Helpers
    
    private func performLoad() {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.load { value in
                DispatchQueue.main.async {
                    self?.value = value
                }
            }
        }
    }
    
}
