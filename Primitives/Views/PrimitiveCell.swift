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
    
    @Binding var isPresentingSettings: Bool

    let primitive: Primitive
    
    var body: some View {
        NavigationButton(
            destination: PrimitiveView(
                favorites: favorites,
                settings: settings,
                isPresentingSettings: $isPresentingSettings,
                primitive: primitive
            )
        ) {
            HStack {
                Text(primitive.name)
                    .font(.headline)

                Spacer()
                
                if favorites[primitive] {
                    // TODO: Why does this appear in the live canvas but not the simulator?
                    Image(systemName: "star.fill")
                        .foregroundColor(.secondary)
                    Text("faved")
                        .foregroundColor(.secondary)
                }
            }
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
                isPresentingSettings: .constant(false),
                primitive: PreviewModels.sphere
            )
            .previewLayout(.sizeThatFits)
            
            NavigationView {
                List {
                    PrimitiveCell(
                        favorites: .init(),
                        settings: .init(),
                        isPresentingSettings: .constant(false),
                        primitive: PreviewModels.box
                    )
                }
                .navigationBarTitle(Text("Mock List"))
            }
        }
    }
}
#endif
