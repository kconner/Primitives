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

    private let feedbackGenerator = UISelectionFeedbackGenerator()

    var body: some View {
        Button(
            action: {
                withAnimation(.spring()) {
                    self.favorites.toggle(self.primitive)
                }
                
                self.feedbackGenerator.selectionChanged()
            },
            label: {
                VStack {
                    Image(systemName: favorites[primitive] ? "star.fill" : "star")
                    Text("Favorite")
                }
                .foregroundColor(.accentColor)
                .font(.title)
                .padding()
            }
        )
        .scaleEffect(favorites[primitive] ? 1.0 : 0.75)
        .accessibility(label: Text("Favorite"))
        .accessibility(addTraits: favorites[primitive] ? [.isSelected] : [])
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
