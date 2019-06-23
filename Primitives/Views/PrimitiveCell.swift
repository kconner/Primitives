//
//  PrimitiveCell.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveCell : View {
    var body: some View {
        NavigationButton(
            destination: PrimitiveView()
        ) {
            HStack {
                Text("Primitive")
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundColor(.secondary)
            }
        }
    }
}

#if DEBUG
struct PrimitiveCell_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            PrimitiveCell()
                .previewLayout(.sizeThatFits)
            
            NavigationView {
                List {
                    PrimitiveCell()
                }
                .navigationBarTitle(Text("Mock List"))
            }
        }
    }
}
#endif
