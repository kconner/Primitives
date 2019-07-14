//
//  NibBackedView.swift
//  Primitives
//
//  Created by Kevin Conner on 7/13/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit

class NibBackedView : UIView {
    
    @IBOutlet private var containerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibIfNeeded()
    }
    
    // MARK: - UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadNibIfNeeded()
    }

    // MARK: - NSObject
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNibIfNeeded()
    }
    
    // MARK: - Helpers
    
    private func loadNibIfNeeded() {
        if containerView != nil {
            return
        }
        
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib.init(nibName: nibName, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        
        guard containerView != nil else {
            fatalError("Expected the nib to load and set containerView")
        }
        
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(containerView)
    }
    
}
