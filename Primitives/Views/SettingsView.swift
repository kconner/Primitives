//
//  SettingsView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct SettingsView : View {
    
    @ObjectBinding var settings: SettingsService
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Material")
                .font(.headline)
            
            GridPicker(
                selection: selectedMaterialTag,
                options: Array(0 ..< Material.allCases.count)
            ) { tag in
                self.materialView(for: Material.allCases[tag])
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Settings"), displayMode: .automatic)
        .navigationBarItems(trailing: doneButton)
    }
    
    // MARK: - Helpers
    
    private var selectedMaterialTag: Binding<GridPickerTag> {
        Binding(
            getValue: {
                Material.allCases.firstIndex(of: self.settings.material) ?? 0
            }, setValue: { tag in
                self.settings.material = Material.allCases[tag]
            }
        )
    }
    
    private func materialView(for material: Material) -> MaterialView {
        MaterialView(
            material: material,
            isSelected: material == self.settings.material
        )
    }

    private var doneButton: some View {
        Button(
            action: {
                self.settings.isPresentingSettings = false
            },
            label: {
                Text("Done")
            }
        )
    }

}

#if DEBUG
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView(
                settings: .init()
            )
        }
    }
}
#endif
