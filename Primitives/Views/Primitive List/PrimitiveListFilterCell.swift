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
    private var selectionDidChange: Observable<PrimitiveListFilterMode>!
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let segmentedControl = self.segmentedControl!
        
        for mode in PrimitiveListFilterMode.allCases {
            segmentedControl.setTitle(mode.title, forSegmentAt: mode.rawValue)
        }
        
        selectionDidChange = segmentedControl.rx.controlEvent(.valueChanged)
            .map { _ in
                PrimitiveListFilterMode(rawValue: segmentedControl.selectedSegmentIndex) ?? .all
            }
    }
    
    func configure(mode: PrimitiveListFilterMode, filterModeObserver: AnyObserver<PrimitiveListFilterMode>) {
        segmentedControl.selectedSegmentIndex = mode.rawValue
        
        selectionDidChange
            .bind(to: filterModeObserver)
            .disposed(by: disposeBag)
    }
    
    // MARK: - UITableViewCell
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
}
