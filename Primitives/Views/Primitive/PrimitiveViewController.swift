//
//  PrimitiveViewController.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit

final class PrimitiveViewController: UIViewController {
    
    @IBOutlet private var primitiveSceneView: PrimitiveSceneView!
    @IBOutlet private var favoriteButton: FavoriteButton!
    
    private var viewModel: PrimitiveViewModel!

    func configure(with viewModel: PrimitiveViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.primitive.name
        
        primitiveSceneView.configure(
            with: viewModel.primitiveSceneViewModel
        )
        
        favoriteButton.configure(
            with: viewModel.favoriteButtonViewModel
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.willAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        viewModel.willDisappear()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "presentSettings"?:
            let navigationController = segue.destination as! UINavigationController
            let settingsViewController = navigationController.topViewController as! SettingsViewController
            settingsViewController.configure(with: viewModel.settingsViewModel)
        default:
            super.prepare(for: segue, sender: sender)
        }
    }
    
}
