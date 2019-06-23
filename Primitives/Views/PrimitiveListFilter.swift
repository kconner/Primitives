//
//  PrimitiveListFilter.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveListFilter : View {
    @Binding var mode: Mode
    
    enum Mode : String, CaseIterable {
        case all
        case favorites
    }
    
    var body: some View {
        SegmentedControl(selection: $mode) {
            Text("All").tag(Mode.all)
            Text("Favorites").tag(Mode.favorites)
        }
    }
}

#if DEBUG
struct PrimitiveListFilter_Previews : PreviewProvider {
    static var previews: some View {
        PrimitiveListFilter(mode: .constant(.all))
            .previewLayout(.sizeThatFits)
    }
}
#endif
