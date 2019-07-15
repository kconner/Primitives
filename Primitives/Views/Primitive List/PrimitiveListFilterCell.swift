//
//  PrimitiveListFilterCell.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PrimitiveListFilterCell : UITableViewCell {
    
    static let identifier = "filterCell"
    
    @IBOutlet private var segmentedControl: UISegmentedControl!
    
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for mode in PrimitiveListFilterMode.allCases {
            segmentedControl.setTitle(mode.title, forSegmentAt: mode.rawValue)
        }
    }
    
    func configure(mode: PrimitiveListFilterMode, filterModeObserver: AnyObserver<PrimitiveListFilterMode>) {
        let segmentedControl = self.segmentedControl!

        segmentedControl.selectedSegmentIndex = mode.rawValue
        
        segmentedControl.rx.controlEvent(.valueChanged)
            .map { _ in
                PrimitiveListFilterMode(rawValue: segmentedControl.selectedSegmentIndex) ?? .all
            }
            .bind(to: filterModeObserver)
            .disposed(by: disposeBag)
    }
    
    // MARK: - UITableViewCell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
}
