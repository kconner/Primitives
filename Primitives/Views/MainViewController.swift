//
//  MainViewController.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var favoriteButton: FavoriteButton!

    private let catalog = CatalogService()
    private let favorites = FavoritesService()
    private let settings = SettingsService()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteButton.configure(favorites: favorites, primitive: Primitive(id: UUID(), name: "Box", geometryType: .box))
    }
    
}
