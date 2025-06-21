//
//  DefaultLabel.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import SwiftUI

struct DefaultLabel: View {

    var text: String
    var font: Font
    var color: Color
    var alignment: TextAlignment
    var lineLimit: Int?

    init(
        text: String = "",
        font: Font = .body,
        color: Color = Color("TextColor"),
        alignment: TextAlignment = .leading,
        lineLimit: Int? = nil
    ) {
        self.text = text
        self.font = font
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
    }
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(color)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
            .frame(maxWidth: .infinity, alignment: alignment.toFrameAlignment())
    }
}

extension TextAlignment {
    func toFrameAlignment() -> Alignment {
        switch self {
        case .leading: return .leading
        case .center: return .center
        case .trailing: return .trailing
        }
    }
}
