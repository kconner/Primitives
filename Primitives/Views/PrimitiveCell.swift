//
//  PrimitiveCell.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveCell : View {
    @ObjectBinding var favorites: Favorites

    let primitive: Primitive
    
    var body: some View {
        NavigationButton(
            destination: PrimitiveView(favorites: favorites, primitive: primitive)
        ) {
            HStack {
                Text(primitive.name)
                    .font(.headline)

                Spacer()
                
                if favorites[primitive] {
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
            PrimitiveCell(favorites: .init(), primitive: PreviewModels.sphere)
                .previewLayout(.sizeThatFits)
            
            NavigationView {
                List {
                    PrimitiveCell(favorites: .init(), primitive: PreviewModels.box)
                }
                .navigationBarTitle(Text("Mock List"))
            }
        }
    }
}
#endif
