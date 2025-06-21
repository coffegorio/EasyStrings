//
//  DefaultButton.swift
//  EasyStrings
//
//  Created by Егорио on 21.06.2025.
//

import SwiftUI

struct DefaultButton: View {
    
    var action: () -> Void = {}
    var buttonTitle: String = ""
    var isFill: Bool = true
    
    var body: some View {
        Button(action: action) {
            Text(buttonTitle)
                .foregroundStyle(isFill ? Color.white : Color("TextColor"))
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    isFill ? Color("AccentColor") : Color.clear
                )
                .overlay(
                    !isFill ? RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("AccentColor"), lineWidth: 1)
                    : nil
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
