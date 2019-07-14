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
        
//        List {
//            PrimitiveListFilter(mode: $filterMode)
        
//            if catalog.value.isLoading {
//                MessageCell(message: Text("Loading…"))
//            }
        
//            ForEach(filteredPrimitives.identified(by: \.name)) { primitive in
//                PrimitiveCell(
//                    favorites: self.favorites,
//                    settings: self.settings,
//                    primitive: primitive
//                )
//            }
        
//            if !catalog.value.isLoading {
//                countCell
//            }
//        }
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
    
//    private var countCell: MessageCell {
//        let count = filteredPrimitives.count
//
//        let unit: String
//        switch filterMode {
//        case .all:
//            unit = count == 1 ? "Primitive" : "Primitives"
//        case .favorites:
//            unit = count == 1 ? "Favorite" : "Favorites"
//        }
//
//        return MessageCell(message: Text("\(count) \(unit)"))
//    }
//
//    private var refreshButton: some View {
//        Button(
//        }, label: {
//            // TODO: Why does this appear in the simulator but not on device?
//            // Image(systemName: "arrow.clockwise")
//            Text("Refresh")
//        }
//        )
//            .disabled(catalog.value.isLoading)
//    }
//
//    private var settingsModal: Modal {
//        Modal(
//            NavigationView {
//                SettingsView(
//                    settings: settings
//                )
//            }
//        ) {
//            self.settings.isPresentingSettings = false
//        }
//    }

}
