//
//  PrimitiveList.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct PrimitiveList : View {
    @ObjectBinding var catalogService: CatalogService
    
    var body: some View {
        let primitives = catalogService.catalog.map { $0.primitives }
        
        return List {
            if primitives.isLoading {
                LoadingCell()
            }
            
            ForEach((primitives.valueIfLoaded ?? []).identified(by: \.name)) { primitive in
                PrimitiveCell(primitive: primitive)
            }
        }
        .navigationBarTitle(Text("Primitives"))
        .navigationBarItems(leading:
            Button(
                action: {
                    self.catalogService.refresh()
                }, label: {
                    Image(systemName: "arrow.clockwise")
                }
            )
            .disabled(primitives.isLoading)
            
        )
    }
}

#if DEBUG
struct PrimitiveList_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrimitiveList(catalogService: PreviewModels.catalogService)
        }
    }
}
#endif
