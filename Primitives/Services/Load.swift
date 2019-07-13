//
//  Load.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

enum Load<Value, Error> where Error : Swift.Error {

    case loading
    case result(Result<Value, Error>)

    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .result:
            return false
        }
    }

    var valueIfLoaded: Value? {
        switch self {
        case .result(.success(let value)):
            return value
        case .loading, .result(.failure):
            return nil
        }
    }

}
