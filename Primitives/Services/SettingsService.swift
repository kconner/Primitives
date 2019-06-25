//
//  SettingsService.swift
//  Primitives
//
//  Created by Kevin Conner on 6/25/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI
import Combine

final class SettingsService : BindableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    var material = Material.white {
        didSet {
            didChange.send()
        }
    }
    
}
