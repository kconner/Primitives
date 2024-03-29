//
//  PrimitiveList.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveList : View {
    
    @ObjectBinding var catalog: CatalogService
    @ObjectBinding var favorites: FavoritesService
    @ObjectBinding var settings: SettingsService
    
    @State private var filterMode = PrimitiveListFilter.Mode.all
    
    var body: some View {
        List {
            PrimitiveListFilter(mode: $filterMode)
            
            if catalog.value.isLoading {
                MessageCell(message: Text("Loading…"))
            }

            ForEach(filteredPrimitives, id: \.name) { primitive in
                PrimitiveCell(
                    favorites: self.favorites,
                    settings: self.settings,
                    primitive: primitive
                )
            }
            
            if !catalog.value.isLoading {
                countCell
            }
        }
        .navigationBarTitle(Text("Primitives"))
        .navigationBarItems(
            leading: refreshButton,
            trailing: SettingsButton(isPresentingSettings: $settings.isPresentingSettings)
        )
        .sheet(
            isPresented: $settings.isPresentingSettings,
            onDismiss: {
                self.settings.isPresentingSettings = false
            }
        ) {
            self.settingsSheet
        }
    }
    
    // MARK: - Helpers

    private var filteredPrimitives: [Primitive] {
        let primitives = catalog.value.valueIfLoaded?.primitives ?? []
        
        switch filterMode {
        case .all:
            return primitives
        case .favorites:
            return primitives.filter { primitive in
                favorites[primitive]
            }
        }
    }
    
    private var countCell: MessageCell {
        let count = filteredPrimitives.count
        
        let unit: String
        switch filterMode {
        case .all:
            unit = count == 1 ? "Primitive" : "Primitives"
        case .favorites:
            unit = count == 1 ? "Favorite" : "Favorites"
        }
        
        return MessageCell(message: Text("\(count) \(unit)"))
    }

    private var refreshButton: some View {
        Button(
            action: {
                self.catalog.reload()
            }, label: {
                Image(systemName: "arrow.clockwise")
                    .imageScale(.large)
            }
        )
        .disabled(catalog.value.isLoading)
    }
    
    private var settingsSheet: some View {
        NavigationView {
            SettingsView(
                settings: settings
            )
        }
    }

}

#if DEBUG
struct PrimitiveList_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveList(
                catalog: PreviewModels.catalogService,
                favorites: .init(),
                settings: .init()
            )
        }
    }
}
#endif
