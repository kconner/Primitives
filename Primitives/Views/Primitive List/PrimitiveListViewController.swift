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
        
        title = NSLocalizedString("Primitives", comment: "Primitive list title")
        
        viewModel.catalog
            .map { !$0.isLoading }
            .drive(refreshButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
//            .presentation(settings.isPresentingSettings ? settingsModal : nil)
    }

    // MARK: - Helpers
    
    @IBAction private func didTapRefresh() {
        viewModel.didTapRefresh()
    }
    
    @IBAction private func didTapSettings() {
        viewModel.didTapSettings()
    }

//    private var filteredPrimitives: [Primitive] {
//        let primitives = catalog.value.valueIfLoaded?.primitives ?? []
//
//        switch filterMode {
//        case .all:
//            return primitives
//        case .favorites:
//            return primitives.filter { primitive in
//                favorites[primitive]
//            }
//        }
//    }
//
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
