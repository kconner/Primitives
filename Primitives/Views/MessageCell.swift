//
//  MessageCell.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct MessageCell : View {
    var message: Text
    
    var body: some View {
        HStack {
            Spacer()
            
            message
                .color(.secondary)
            
            Spacer()
        }
    }
}

#if DEBUG
struct LoadingCell_Previews : PreviewProvider {
    static var previews: some View {
        MessageCell(message: Text("Loading…"))
            .previewLayout(.sizeThatFits)
    }
}
#endif

