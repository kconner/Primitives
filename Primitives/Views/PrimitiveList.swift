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
    
    @State private var filterMode = PrimitiveListFilter.Mode.all
    
    var body: some View {
        List {
            PrimitiveListFilter(mode: $filterMode)
            
            if catalog.value.isLoading {
                LoadingCell()
            }

            ForEach(filteredPrimitives.identified(by: \.name)) { primitive in
                PrimitiveCell(favorites: self.favorites, primitive: primitive)
            }
        }
        .navigationBarTitle(Text("Primitives"))
        .navigationBarItems(leading:
            Button(
                action: {
                    self.catalog.reload()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                }
            )
            .disabled(catalog.value.isLoading)
        )
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

}

#if DEBUG
struct PrimitiveList_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveList(
                catalog: PreviewModels.catalogService,
                favorites: .init()
            )
        }
    }
}
#endif
