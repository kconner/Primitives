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
    
    let primitive: Primitive
    
    var body: some View {
        PrimitiveSceneView(geometryType: primitive.geometryType)
            .navigationBarTitle(Text(primitive.name))
            .navigationBarItems(
                trailing: Button(
                    action: {
                        self.favorites.toggle(self.primitive)
                    }, label: {
                        // TODO: Why doesn't this appear?
                        // Image(systemName: favoritesService.favorites.contains(primitive) ? "star.fill" : "star")
                        Text(favorites[primitive] ? "faved" : "fave")
                    }
                )
            )
    }
}

#if DEBUG
struct PrimitiveView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveView(favorites: .init(), primitive: PreviewModels.sphere)
        }
    }
}
#endif
