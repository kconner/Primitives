//
//  PrimitiveListMessageCell.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit

final class PrimitiveListMessageCell : UITableViewCell {
    
    static let identifier = "messageCell"
    
    @IBOutlet private var messageLabel: UILabel!
    
    func configure(message: String) {
        messageLabel.text = message
    }
    
}
