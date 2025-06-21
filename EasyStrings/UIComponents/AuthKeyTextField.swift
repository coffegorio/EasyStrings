//
//  EnterKeyTextField.swift
//  EasyStrings
//
//  Created by Егорио on 21.06.2025.
//

import SwiftUI

struct AuthKeyTextField: View {
    
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text)
            .foregroundStyle(Color("TextColor"))
            .background(.clear)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("AccentColor"), lineWidth: 1))
            .padding()
            .frame(maxWidth: .infinity)
    }
}
