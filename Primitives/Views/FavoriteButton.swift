//
//  FavoriteButton.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit

// TODO: @IBDesignable would be great, but it crashes IB in beta 3
final class FavoriteButton : NibBackedView {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    private var favorites: FavoritesService!
    private var primitive: Primitive!
    
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    
    func configure(favorites: FavoritesService, primitive: Primitive) {
        self.favorites = favorites
        self.primitive = primitive

        let title = NSLocalizedString("Favorite", comment: "Favorite button title")
        label.text = title
        button.accessibilityLabel = title
        
        update()
    }
    
    // MARK: - Helpers

    private func update() {
        let isFavorite = favorites[primitive]
        
        iconImageView.image = UIImage(systemName: isFavorite ? "star.fill" : "star")
        
        let scale: CGFloat = isFavorite ? 1.0 : 0.75
        transform = CGAffineTransform(scaleX: scale, y: scale)
        
        button.isSelected = isFavorite
    }
    
    @IBAction private func didTap() {
        UIView.animate(
            withDuration: 0.333,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: [],
            animations: {
                self.favorites[self.primitive].toggle()
                self.update()
            },
            completion: nil
        )
        
        self.feedbackGenerator.selectionChanged()
    }
    
    // MARK: - NSObject
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure(favorites: .init(), primitive: PreviewModels.box)
    }

}
