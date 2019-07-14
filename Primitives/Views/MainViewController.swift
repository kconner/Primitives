//
//  MainViewController.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let catalog = CatalogService()
    private let favorites = FavoritesService()
    private let settings = SettingsService()

    private let mockPrimitive = Primitive(id: UUID(), name: "Box", geometryType: .box)

    // MARK: - UIViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPrimitive"?:
            let primitiveViewController = segue.destination as! PrimitiveViewController
            
            primitiveViewController.configure(
                with: PrimitiveViewModel(
                    favorites: favorites,
                    settings: settings,
                    primitive: mockPrimitive
                )
            )
        default:
            super.prepare(for: segue, sender: sender)
        }
    }
    
}
