//
//  CatalogService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI
import Combine

final class CatalogService : BindableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    private(set) var catalog: Load<Catalog> = .loading {
        didSet {
            didChange.send()
        }
    }
    
    convenience init() {
        self.init(catalog: .loading)
    }
    
    init(catalog: Load<Catalog>) {
        self.catalog = catalog
        
        if catalog.isLoading {
            loadCatalog()
        }
    }
    
    func refresh() {
        guard !catalog.isLoading else {
            return
        }
        
        loadCatalog()
    }
    
    // MARK: - Helpers
    
    private func loadCatalog() {
        catalog = .loading
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let url = Bundle.main.url(forResource: "catalog", withExtension: "json") else {
                fatalError("Expected the catalog to be bundled with the application")
            }
            
            do {
                let data = try Data(contentsOf: url)
                let catalog = try JSONDecoder().decode(Catalog.self, from: data)
                
                DispatchQueue.main.async {
                    self?.catalog = .loaded(catalog)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.catalog = .failed(error)
                }
            }
        }
    }
    
}
