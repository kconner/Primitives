//
//  PrimitiveCell.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveCell : View {
    @ObjectBinding var favoritesService: FavoritesService

    let primitive: Primitive
    
    var body: some View {
        NavigationButton(
            destination: PrimitiveView(favoritesService: favoritesService, primitive: primitive)
        ) {
            HStack {
                PrimitiveSceneView(geometryType: primitive.geometryType, allowsCameraControl: false)
                    .frame(width: 50, height: 70)
                
                Text(primitive.name)
                    .font(.headline)

                Spacer()
                
                if favoritesService.favorites.contains(primitive) {
                    // TODO: Why doesn't this appear?
                    // Image(systemName: "star.fill")
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
            PrimitiveCell(favoritesService: .init(), primitive: PreviewModels.sphere)
                .previewLayout(.sizeThatFits)
            
            NavigationView {
                List {
                    PrimitiveCell(favoritesService: .init(), primitive: PreviewModels.box)
                }
                .navigationBarTitle(Text("Mock List"))
            }
        }
    }
}
#endif
