//
//  MainView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct MainView : View {
    let catalogService: CatalogService
    let favoritesService: FavoritesService
    
    var body: some View {
        NavigationView {
            PrimitiveList(catalogService: catalogService, favoritesService: favoritesService)
        }
    }
}

#if DEBUG
struct MainView_Previews : PreviewProvider {
    static var previews: some View {
        MainView(catalogService: PreviewModels.catalogService, favoritesService: .init())
    }
}
#endif
