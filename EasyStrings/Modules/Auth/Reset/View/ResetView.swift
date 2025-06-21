//
//  ResetView.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import SwiftUI

struct ResetView: View {
    @ObservedObject var viewModel: ResetViewModel
    @FocusState private var isEmailFocused: Bool
    @State private var showSuccessMessage = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                DefaultLabel(text: "Восстановление доступа", font: .title)
                DefaultLabel(text: "Введите email, указанный при регистрации. Мы отправим инструкции по восстановлению доступа.")
                
                VStack(alignment: .leading, spacing: 10) {
                    DefaultLabel(text: "Email", font: .headline)
                    
                    TextField("example@email.com", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .focused($isEmailFocused)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isEmailFocused ? Color("AccentColor") : Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .onChange(of: viewModel.email) { _ in
                            viewModel.validateEmail()
                        }
                    
                    if !viewModel.emailError.isEmpty {
                        Text(viewModel.emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                            .transition(.opacity)
                    }
                }
                
                if showSuccessMessage {
                    VStack(spacing: 15) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                            .scaleEffect(showSuccessMessage ? 1.0 : 0.5)
                            .animation(.spring(response: 0.6, dampingFraction: 0.6), value: showSuccessMessage)
                        
                        DefaultLabel(
                            text: "Инструкции отправлены!",
                            font: .headline,
                            alignment: .center
                        )
                        
                        DefaultLabel(
                            text: "Проверьте вашу почту и следуйте инструкциям для восстановления доступа.",
                            font: .body,
                            alignment: .center
                        )
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    )
                    .transition(.opacity.combined(with: .scale))
                }
                
                Spacer()
                
                VStack(spacing: 15) {
                    DefaultButton(
                        action: {
                            if showSuccessMessage {
                                showSuccessMessage = false
                                viewModel.resetForm()
                            } else {
                                viewModel.sendResetInstructions()
                            }
                        },
                        buttonTitle: showSuccessMessage ? "Отправить еще раз" : "Отправить инструкции",
                        isFill: true
                    )
                    .disabled(!viewModel.isEmailValid && !showSuccessMessage)
                    .opacity((!viewModel.isEmailValid && !showSuccessMessage) ? 0.6 : 1.0)
                    
                    DefaultButton(
                        action: {
                            viewModel.goBack()
                        },
                        buttonTitle: "Назад к входу",
                        isFill: false
                    )
                }
            }
            .padding(20)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            isEmailFocused = false
        }
        .onReceive(viewModel.$resetSuccess) { success in
            if success {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSuccessMessage = true
                }
            }
        }
    }
} 