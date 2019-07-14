//
//  PrimitiveListPrimitiveCell.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PrimitiveListPrimitiveCell : UITableViewCell {
    
    static let identifier = "primitiveCell"
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var favoriteImageView: UIImageView!
    
    private var disposeBag = DisposeBag()
    
    func configure(primitive: Primitive, isFavorite: Driver<Bool>) {
        nameLabel.text = primitive.name
        
        let favoriteImageView = self.favoriteImageView
        
        isFavorite
            .drive(onNext: { isFavorite in
                favoriteImageView?.image = UIImage(systemName: isFavorite ? "star.fill" : "star")
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UITableViewCell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }

}
