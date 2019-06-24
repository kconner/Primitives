//
//  FavoriteButton.swift
//  Primitives
//
//  Created by Kevin Conner on 6/24/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct FavoriteButton : View {
    @ObjectBinding var favorites: FavoritesService
    
    let primitive: Primitive

    var body: some View {
        Button(
            action: {
                withAnimation(.spring()) {
                    self.favorites.toggle(self.primitive)
                }
            },
            label: {
                VStack {
                    // TODO: Why does this appear in the live canvas but not the simulator?
                    Image(systemName: favorites[primitive] ? "star.fill" : "star")
                    Text(favorites[primitive] ? "faved" : "fave")
                }
                .font(.title)
                .padding()
            }
        )
        .scaleEffect(favorites[primitive] ? 1.0 : 0.75)
    }
}

#if DEBUG
struct FavoriteButton_Previews : PreviewProvider {
    static var previews: some View {
        FavoriteButton(favorites: .init(), primitive: PreviewModels.box)
            .previewLayout(.sizeThatFits)
    }
}
#endif
