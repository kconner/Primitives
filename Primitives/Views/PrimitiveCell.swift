//
//  PrimitiveCell.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveCell : View {
    
    @ObjectBinding var favorites: FavoritesService
    @ObjectBinding var settings: SettingsService
    
    let primitive: Primitive
    
    var body: some View {
        NavigationLink(
            destination: PrimitiveView(
                favorites: favorites,
                settings: settings,
                primitive: primitive
            )
        ) {
            HStack {
                Text(primitive.name)
                    .font(.headline)

                Spacer()
                
                if favorites[primitive] {
                    Image(systemName: "star.fill")
                        .foregroundColor(.secondary)
                        .accessibility(label: Text("Favorite"))
                }
            }
        }
        .accessibilityAction(named: self.favorites[self.primitive] ? Text("Unfavorite") : Text("Favorite")) {
            self.favorites.toggle(self.primitive)
        }
    }
    
}

#if DEBUG
struct PrimitiveCell_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            PrimitiveCell(
                favorites: .init(),
                settings: .init(),
                primitive: PreviewModels.sphere
            )
            .previewLayout(.sizeThatFits)
            
            NavigationView {
                List {
                    PrimitiveCell(
                        favorites: .init(),
                        settings: .init(),
                        primitive: PreviewModels.box
                    )
                }
                .navigationBarTitle(Text("Mock List"))
            }
        }
    }
}
#endif
