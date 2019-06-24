//
//  GridPicker.swift
//  Primitives
//
//  Created by Kevin Conner on 6/24/19.
//  Copyright © 2019 Kevin Conner. All rights reserved.
//

import SwiftUI

typealias GridPickerTag = Int

struct GridPicker<Cell> : View
    where Cell : View
{
    
    private struct Row : Identifiable {
        var id: Int
        var options: [GridPickerTag]
    }
    
    @Binding var selection: GridPickerTag
    
    var options: [GridPickerTag]
    var makeCell: (GridPickerTag) -> Cell
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(Self.rows(for: options, by: 2)) { section in
                HStack(spacing: 24) {
                    ForEach(section.options) { tag in
                        Button(
                            action: {
                                withAnimation(.basic(duration: 0.2, curve: .easeIn)) {
                                    self.selection = tag
                                }
                            }, label: {
                                self.makeCell(tag).tag(tag)
                            }
                        )
                    }
                }
            }
        }
    }
    
    // MARK: - Helpers
    
    private static func rows(for options: [GridPickerTag], by count: Int) -> [Row] {
        let offsets = stride(from: options.startIndex, to: options.endIndex, by: count)
        
        return offsets.map { index in
            Row(
                id: index,
                options: Array(options[index ..< min(index + count, options.endIndex)])
            )
        }
    }
    
}

#if DEBUG
struct GridView_Previews : PreviewProvider {
    static var previews: some View {
        GridPicker(selection: .constant(1), options: Array(0..<4)) { option in
            Text("Example")
        }
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
#endif
