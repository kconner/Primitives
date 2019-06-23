//
//  PrimitiveView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveView : View {
    var primitive: Primitive
    
    var body: some View {
        PrimitiveSceneView(geometryType: primitive.geometryType)
            .navigationBarTitle(Text(primitive.name))
    }
}

#if DEBUG
struct PrimitiveView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveView(primitive: PreviewModels.sphere)
        }
    }
}
#endif
