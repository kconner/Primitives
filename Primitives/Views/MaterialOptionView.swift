//
//  MaterialOptionView.swift
//  Primitives
//
//  Created by Kevin Conner on 6/24/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

enum MaterialOption : CaseIterable {
    
    case black
    case white
    case cyan
    case magenta
    
    var name: String {
        switch self {
        case .black:
            return "Black"
        case .white:
            return "White"
        case .cyan:
            return "Cyan"
        case .magenta:
            return "Magenta"
        }
    }
    
    var gradient: Gradient {
        switch self {
        case .black:
            return .init(colors: [.black, .init(white: 0.3)])
        case .white:
            return .init(colors: [.white, .init(white: 0.7)])
        case .cyan:
            return .init(colors: [
                Color(hue: 0.5, saturation: 1.0, brightness: 1.0),
                Color(hue: 0.5, saturation: 1.0, brightness: 0.7)
            ])
        case .magenta:
            return .init(colors: [
                Color(hue: 0.833, saturation: 1.0, brightness: 1.0),
                Color(hue: 0.833, saturation: 1.0, brightness: 0.7)
            ])
        }
    }
    
}

struct MaterialOptionView : View {
    
    var option: MaterialOption
    var isSelected: Bool
    
    var body: some View {
        VStack {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.blue, lineWidth: 3)
                        .blur(radius: 2)
                }
                
                Rectangle()
                    .fill(LinearGradient(gradient: option.gradient, startPoint: .top, endPoint: .bottom))
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(color: .secondary
                        , radius: 3, x: 0, y: 3)
                    .padding(2)
            }
            .aspectRatio(contentMode: .fill)
            
            Text(option.name)
                .color(.secondary)
                .font(.callout)
        }
    }
    
}

#if DEBUG
struct MaterialOptionView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            MaterialOptionView(option: .black, isSelected: false)
            MaterialOptionView(option: .cyan, isSelected: true)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
