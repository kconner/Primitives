//
//  PrimitiveView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveView : View {

    @ObjectBinding var favorites: FavoritesService
    @ObjectBinding var settings: SettingsService
    @ObjectBinding private var proximity = ProximityService()
    
    let primitive: Primitive
    
    var body: some View {
        PrimitiveSceneView(
            proximity: proximity,
            geometryType: primitive.geometryType,
            material: $settings.material
        )
        .overlay(
            FavoriteButton(favorites: favorites, primitive: primitive),
            alignment: .bottom
        )
        .navigationBarTitle(Text(primitive.name))
        .navigationBarItems(
            trailing: SettingsButton(isPresentingSettings: $settings.isPresentingSettings)
        )
    }

}

#if DEBUG
struct PrimitiveView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveView(
                favorites: .init(),
                settings: .init(),
                primitive: PreviewModels.sphere
            )
        }
    }
}
#endif
