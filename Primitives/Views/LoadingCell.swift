//
//  LoadingCell.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct LoadingCell : View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("Loading…")
                .font(.headline)
                .color(.secondary)
            
            Spacer()
        }
    }
}

#if DEBUG
struct LoadingCell_Previews : PreviewProvider {
    static var previews: some View {
        LoadingCell()
            .previewLayout(.sizeThatFits)
    }
}
#endif

