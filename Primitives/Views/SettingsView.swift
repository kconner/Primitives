//
//  SettingsView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct SettingsView : View {
    
    @Binding var isPresentingSettings: Bool
    
    @State private var selectedMaterialOptionTag = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Material")
                .font(.headline)
            
            GridPicker(selection: $selectedMaterialOptionTag, options: Array(0..<MaterialOption.allCases.count)) { tag in
                MaterialOptionView(
                    option: MaterialOption.allCases[tag],
                    isSelected: tag == self.selectedMaterialOptionTag
                )
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Settings"), displayMode: .automatic)
        .navigationBarItems(
            trailing: Button(
                action: {
                    self.isPresentingSettings = false
                },
                label: {
                    Text("Done")
                }
            )
        )
    }


}

#if DEBUG
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(isPresentingSettings: .constant(true))
        }
    }
}
#endif
