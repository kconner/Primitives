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

    @Binding var isPresentingSettings: Bool
    @Binding var material: Material
    
    let primitive: Primitive
    
    var body: some View {
        PrimitiveSceneView(
            material: $material,
            geometryType: primitive.geometryType
        )
        .overlay(
            FavoriteButton(favorites: favorites, primitive: primitive),
            alignment: .bottom
        )
        .navigationBarTitle(Text(primitive.name))
        .navigationBarItems(
            trailing: SettingsButton(isPresentingSettings: $isPresentingSettings)
        )
    }

}

#if DEBUG
struct PrimitiveView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveView(
                favorites: .init(),
                isPresentingSettings: .constant(false),
                material: .constant(.black),
                primitive: PreviewModels.sphere
            )
        }
    }
}
#endif
