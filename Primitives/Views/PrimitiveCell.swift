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
    
    @Binding var isPresentingSettings: Bool
    @Binding var material: Material

    let primitive: Primitive
    
    var body: some View {
        NavigationButton(
            destination: PrimitiveView(
                favorites: favorites,
                isPresentingSettings: $isPresentingSettings,
                material: $material,
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
                isPresentingSettings: .constant(false),
                material: .constant(.black),
                primitive: PreviewModels.sphere
            )
            .previewLayout(.sizeThatFits)
            
            NavigationView {
                List {
                    PrimitiveCell(
                        favorites: .init(),
                        isPresentingSettings: .constant(false),
                        material: .constant(.black),
                        primitive: PreviewModels.box
                    )
                }
                .navigationBarTitle(Text("Mock List"))
            }
        }
    }
}
#endif
