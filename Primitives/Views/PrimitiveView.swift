//
//  PrimitiveView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveView : View {
    @ObjectBinding var favoritesService: FavoritesService
    
    let primitive: Primitive
    
    var body: some View {
        PrimitiveSceneView(geometryType: primitive.geometryType)
            .navigationBarTitle(Text(primitive.name))
            .navigationBarItems(
                trailing: Button(
                    action: {
                        self.favoritesService.favorites.formSymmetricDifference([self.primitive])
                    }, label: {
                        // TODO: Why doesn't this appear?
                        // Image(systemName: favoritesService.favorites.contains(primitive) ? "star.fill" : "star")
                        Text(favoritesService.favorites.contains(primitive) ? "faved" : "fave")
                    }
                )
            )
    }
}

#if DEBUG
struct PrimitiveView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveView(favoritesService: .init(), primitive: PreviewModels.sphere)
        }
    }
}
#endif
