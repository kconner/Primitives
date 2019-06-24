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

    var body: some View {
        Text("Settings")
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
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
