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
    var favoritesService: FavoritesService
    
    @State private var filterMode = PrimitiveListFilter.Mode.all
    
    var body: some View {
        List {
            PrimitiveListFilter(mode: $filterMode)
            
            if primitives.isLoading {
                LoadingCell()
            }

            ForEach(filteredPrimitives.identified(by: \.name)) { primitive in
                PrimitiveCell(favoritesService: self.favoritesService, primitive: primitive)
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
            .disabled(primitives.isLoading)
        )
    }
    
    // MARK: - Helpers

    private var primitives: Load<[Primitive]> {
        catalogService.catalog.map { $0.primitives }
    }

    private var filteredPrimitives: [Primitive] {
        let allPrimitives = primitives.valueIfLoaded ?? []
        
        switch filterMode {
        case .all:
            return allPrimitives
        case .favorites:
            return allPrimitives.filter { primitive in
                favoritesService.favorites.contains(primitive)
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
                favoritesService: .init()
            )
        }
    }
}
#endif
