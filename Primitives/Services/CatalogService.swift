//
//  CatalogService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI
import Combine

final class CatalogService : LoadService<Catalog> {
    
    init() {
        super.init { fulfill in
            guard let url = Bundle.main.url(forResource: "catalog", withExtension: "json") else {
                fatalError("Expected the catalog to be bundled with the application")
            }
            
            do {
                let data = try Data(contentsOf: url)
                let catalog = try JSONDecoder().decode(Catalog.self, from: data)

                fulfill(.loaded(catalog))
            } catch {
                fulfill(.failed(error))
            }
        }
    }

    init(value: Load<Catalog>) {
        super.init { fulfill in
            fulfill(value)
        }
    }
    
}
