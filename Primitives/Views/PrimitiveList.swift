//
//  PrimitiveList.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveList : View {
    
    @ObjectBinding var catalogService: CatalogService
    var favorites: Favorites
    
    @State private var filterMode = PrimitiveListFilter.Mode.all
    
    var body: some View {
        List {
            PrimitiveListFilter(mode: $filterMode)
            
            if catalogService.catalog.isLoading {
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
                    self.catalogService.refresh()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                }
            )
            .disabled(catalogService.catalog.isLoading)
        )
    }
    
    // MARK: - Helpers

    private var filteredPrimitives: [Primitive] {
        let primitives = catalogService.catalog.valueIfLoaded?.primitives ?? []
        
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
                catalogService: PreviewModels.catalogService,
                favorites: .init()
            )
        }
    }
}
#endif
