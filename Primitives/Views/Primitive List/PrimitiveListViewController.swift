//
//  PrimitiveListViewController.swift
//  Primitives
//
//  Created by Kevin Conner on 7/14/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PrimitiveListViewController : UITableViewController {
    
    @IBOutlet private var refreshButton: UIBarButtonItem!
    
    private var viewModel: PrimitiveListViewModel!
    private let disposeBag = DisposeBag()
    
    private var items: [PrimitiveListItem] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    func configure(with viewModel: PrimitiveListViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Primitives", comment: "Primitive list title")
        
        viewModel.isLoading
            .map { !$0 }
            .drive(refreshButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.items
            .drive(onNext: { [weak self] items in
                self?.items = items
            })
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "presentSettings"?:
            let navigationController = segue.destination as! UINavigationController
            let settingsViewController = navigationController.topViewController as! SettingsViewController
            settingsViewController.configure(with: viewModel.settingsViewModel)
        default:
            super.prepare(for: segue, sender: sender)
        }
    }

    // MARK: - Helpers
    
    @IBAction private func didTapRefresh() {
        viewModel.didTapRefresh()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        switch item {
        case .filter(let mode):
            let cell = tableView.dequeueReusableCell(withIdentifier: PrimitiveListFilterCell.identifier, for: indexPath) as! PrimitiveListFilterCell
            cell.configure(mode: mode, filterModeObserver: viewModel.filterModeObserver)
            return cell
        case .primitive:
            // TODO
            return UITableViewCell()
        case .message(let message):
            let cell = tableView.dequeueReusableCell(withIdentifier: PrimitiveListMessageCell.identifier, for: indexPath) as! PrimitiveListMessageCell
            cell.configure(message: message)
            return cell
        }
    }

}
