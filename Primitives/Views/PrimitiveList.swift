//
//  PrimitiveList.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveList : View {
    var primitives: [Primitive]
    
    var body: some View {
        List {
            ForEach(primitives.identified(by: \.name)) { primitive in
                PrimitiveCell(primitive: primitive)
            }
        }
        .navigationBarTitle(Text("Primitives"))
    }
}

#if DEBUG
struct PrimitiveList_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveList(primitives: PreviewModels.primitives)
        }
    }
}
#endif
