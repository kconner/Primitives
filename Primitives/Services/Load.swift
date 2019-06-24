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

}
