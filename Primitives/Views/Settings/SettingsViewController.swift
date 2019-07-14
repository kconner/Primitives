//
//  SettingsViewController.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import RxSwift

final class SettingsViewController : UIViewController {
    
    @IBOutlet var button: UIButton!
    
    private var viewModel: SettingsViewModel!
    private let disposeBag = DisposeBag()
    
    func configure(with viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.material
            .map { $0.name }
            .drive(button.rx.title())
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helpers
    
    @IBAction private func didTapCyan() {
        viewModel.setMaterial(.cyan)
    }
    
}
