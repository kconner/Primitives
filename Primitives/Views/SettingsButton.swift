//
//  SettingsButton.swift
//  Primitives
//
//  Created by Kevin Conner on 6/23/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

struct SettingsButton : View {
    @Binding var isPresentingSettings: Bool

    var body: some View {
        Button(
            action: {
                self.isPresentingSettings = true
            },
            label: {
                Image(systemName: "gear")
            }
        )
    }
}

#if DEBUG
struct SettingsButton_Previews : PreviewProvider {
    static var previews: some View {
        SettingsButton(isPresentingSettings: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
#endif
