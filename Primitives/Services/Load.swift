//
//  Load.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation

enum Load<Value> {
    
    case loading
    case loaded(Value)
    case failed(Error)
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .loaded, .failed:
            return false
        }
    }
    
    var valueIfLoaded: Value? {
        switch self {
        case .loaded(let value):
            return value
        case .loading, .failed:
            return nil
        }
    }
    
    var errorIfFailed: Error? {
        switch self {
        case .failed(let error):
            return error
        case .loading, .loaded:
            return nil
        }
    }
    
    func map<U>(_ transform: (Value) -> U) -> Load<U> {
        switch self {
        case .loading:
            return .loading
        case .loaded(let value):
            return .loaded(transform(value))
        case .failed(let error):
            return .failed(error)
        }
    }

}
