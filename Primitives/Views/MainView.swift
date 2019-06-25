//
//  MainView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct MainView : View {
    let catalog: CatalogService
    let favorites: FavoritesService
    let settings: SettingsService
    
    var body: some View {
        NavigationView {
            PrimitiveList(
                catalog: catalog,
                favorites: favorites,
                settings: settings
            )
        }
    }
}

#if DEBUG
struct MainView_Previews : PreviewProvider {
    static var previews: some View {
        MainView(
            catalog: PreviewModels.catalogService,
            favorites: .init(),
            settings: .init()
        )
    }
}
#endif
