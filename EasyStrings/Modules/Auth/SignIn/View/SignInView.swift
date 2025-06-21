//
//  SignInView.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    @FocusState private var focusedField: AuthKeyField?
    
    
    enum AuthKeyField: Int, CaseIterable {
        case field0, field1, field2, field3, field4, field5
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                DefaultLabel(text: "Добро пожаловать!", font: .title)
                DefaultLabel(text: "Введите ключ-доступа для в доступа в вашу учетную запись.")
                
                HStack(spacing: 10) {
                    ForEach(0..<6, id: \.self) { index in
                        TextField("", text: $viewModel.authKeyDigits[index])
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .focused($focusedField, equals: AuthKeyField(rawValue: index))
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color("AccentColor"), lineWidth: 1)
                            )
                            .onChange(of: viewModel.authKeyDigits[index]) { newValue in
                                if newValue.count > 1 {
                                    viewModel.authKeyDigits[index] = String(newValue.last!)
                                }
                                
                                if !newValue.isEmpty && index < 5 {
                                    focusedField = AuthKeyField(rawValue: index + 1)
                                }
                                
                                if newValue.isEmpty && index > 0 {
                                    focusedField = AuthKeyField(rawValue: index - 1)
                                }
                            }
                    }
                }
                DefaultButton(action: {
                    viewModel.signIn()
                }, buttonTitle: "Войти", isFill: true)
                DefaultButton(action: {
                    viewModel.generateKey()
                }, buttonTitle: "Сгенерировать ключ", isFill: false)
                Button {
                    viewModel.resetAccess()
                } label: {
                    Text("Я потерял свой код")
                        .foregroundStyle(Color("TextColor"))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(20)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            focusedField = nil
        }
    }
}
