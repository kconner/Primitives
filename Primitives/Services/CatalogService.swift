//
//  CatalogService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import Foundation

final class CatalogService : LoadedValueService<Catalog, Error> {
    
    init() {
        super.init { fulfill in
            guard let url = Bundle.main.url(forResource: "catalog", withExtension: "json") else {
                fatalError("Expected the catalog to be bundled with the application")
            }
            
            do {
                let data = try Data(contentsOf: url)
                let catalog = try JSONDecoder().decode(Catalog.self, from: data)

                fulfill(.success(catalog))
            } catch {
                fulfill(.failure(error))
            }
        }
    }

    init(value: Result<Catalog, Error>) {
        super.init { fulfill in
            fulfill(value)
        }
    }
    
}
