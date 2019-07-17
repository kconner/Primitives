//
//  FavoriteButton.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
        
        button.rx.tap
            .bind(to: viewModel.toggleObserver)
            .disposed(by: disposeBag)
        
        viewModel.isFavorite
            .drive(onNext: { [weak self] isFavorite in
                self?.updateFavorite(to: isFavorite)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helpers

    private func updateFavorite(to isFavorite: Bool) {
        iconImageView.image = UIImage(systemName: isFavorite ? "star.fill" : "star")
        
        button.isSelected = isFavorite
        
        UIView.animate(
            withDuration: 0.333,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: [],
            animations: {
                let scale: CGFloat = isFavorite ? 1.0 : 0.75
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
            },
            completion: nil
        )
    }
    
    @IBAction private func didTap() {
        self.feedbackGenerator.selectionChanged()
    }
    
    // MARK: - NSObject
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure(with: FavoriteButtonViewModel(favorites: .init(), primitive: PreviewModels.box))
    }

}
