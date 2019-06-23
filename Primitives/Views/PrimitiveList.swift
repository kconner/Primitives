//
//  PrimitiveList.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveList : View {
    var body: some View {
        List {
            PrimitiveCell()
            PrimitiveCell()
        }
        .navigationBarTitle(Text("Primitives"))
    }
}

#if DEBUG
struct PrimitiveList_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveList()
        }
    }
}
#endif
