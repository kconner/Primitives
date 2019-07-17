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
    
    @IBOutlet private var reloadButton: UIBarButtonItem!
    
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
        
        reloadButton.rx.tap
            .bind(to: viewModel.reload)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .map { !$0 }
            .drive(reloadButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.items
            .drive(onNext: { [weak self] items in
                self?.items = items
            })
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPrimitive"?:
            let primitiveViewController = segue.destination as! PrimitiveViewController
            
            guard let selectedIndexPath = tableView.indexPathForSelectedRow,
                case .primitive(let primitive) = items[selectedIndexPath.row] else
            {
                assertionFailure("Expected a primitive cell to be selected")
                return
            }
            
            primitiveViewController.configure(with: viewModel.primitiveViewModel(for: primitive))
        case "presentSettings"?:
            let navigationController = segue.destination as! UINavigationController
            let settingsViewController = navigationController.topViewController as! SettingsViewController
            settingsViewController.configure(with: viewModel.settingsViewModel)
        default:
            super.prepare(for: segue, sender: sender)
        }
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
            
            cell.configure(
                mode: mode,
                setMode: viewModel.setFilterMode
            )
            
            return cell
        case .primitive(let primitive):
            let cell = tableView.dequeueReusableCell(withIdentifier: PrimitiveListPrimitiveCell.identifier, for: indexPath) as! PrimitiveListPrimitiveCell
            
            cell.configure(
                primitive: primitive,
                isFavorite: viewModel.isFavorite(primitive)
            )
            
            return cell
        case .message(let message):
            let cell = tableView.dequeueReusableCell(withIdentifier: PrimitiveListMessageCell.identifier, for: indexPath) as! PrimitiveListMessageCell
            
            cell.configure(message: message)
            
            return cell
        }
    }

}
