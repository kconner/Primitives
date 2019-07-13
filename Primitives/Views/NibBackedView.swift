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
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadNib()
    }

    // MARK: - NSObject
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNib()
    }
    
    // MARK: - Helpers
    
    private func loadNib() {
        let nib = UINib.init(nibName: String(describing: type(of: self)), bundle: nil)
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
