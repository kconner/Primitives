//
//  FavoriteButton.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import RxSwift

@IBDesignable final class FavoriteButton : NibBackedView {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    private var viewModel: FavoriteButtonViewModel!
    private let disposeBag = DisposeBag()
    
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    
    func configure(with viewModel: FavoriteButtonViewModel) {
        self.viewModel = viewModel
        
        let title = NSLocalizedString("Favorite", comment: "Favorite button title")
        label.text = title
        button.accessibilityLabel = title
        
        viewModel.isFavorite
            .drive(onNext: { [weak self] isFavorite in
                self?.update(isFavorite: isFavorite)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helpers

    private func update(isFavorite: Bool) {
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
                self.viewModel.toggle()
            },
            completion: nil
        )
        
        self.feedbackGenerator.selectionChanged()
    }
    
    // MARK: - NSObject
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure(with: FavoriteButtonViewModel(favorites: .init(), primitive: PreviewModels.box))
    }

}
