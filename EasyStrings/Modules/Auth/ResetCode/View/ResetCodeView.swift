//
//  ResetCodeView.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import SwiftUI

struct ResetCodeView: View {
    @ObservedObject var viewModel: ResetCodeViewModel
    @FocusState private var focusedField: ResetCodeField?
    @State private var showSuccessMessage = false
    
    enum ResetCodeField: Int, CaseIterable {
        case field0, field1, field2, field3, field4, field5
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                DefaultLabel(text: "Код подтверждения", font: .title)
                DefaultLabel(text: "Введите 6-значный код, отправленный на ваш email.")
                
                VStack(spacing: 20) {
                    // Поля для ввода кода
                    HStack(spacing: 10) {
                        ForEach(0..<6, id: \.self) { index in
                            TextField("", text: $viewModel.resetCodeDigits[index])
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .focused($focusedField, equals: ResetCodeField(rawValue: index))
                                .frame(height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(focusedField == ResetCodeField(rawValue: index) ? Color("AccentColor") : Color.gray.opacity(0.3), lineWidth: 1)
                                        )
                                )
                                .onChange(of: viewModel.resetCodeDigits[index]) { newValue in
                                    if newValue.count > 1 {
                                        viewModel.resetCodeDigits[index] = String(newValue.last!)
                                    }
                                    
                                    if !newValue.isEmpty && index < 5 {
                                        focusedField = ResetCodeField(rawValue: index + 1)
                                    }
                                    
                                    if newValue.isEmpty && index > 0 {
                                        focusedField = ResetCodeField(rawValue: index - 1)
                                    }
                                    
                                    // Автоматическая проверка кода при заполнении всех полей
                                    if viewModel.resetCodeDigits.allSatisfy({ !$0.isEmpty }) {
                                        viewModel.verifyCode()
                                    }
                                }
                        }
                    }
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
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
                            text: "Код подтвержден!",
                            font: .headline,
                            alignment: .center
                        )
                        
                        DefaultLabel(
                            text: "Теперь вы можете создать новый ключ-доступа.",
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
                                viewModel.createNewKey()
                            } else {
                                viewModel.verifyCode()
                            }
                        },
                        buttonTitle: showSuccessMessage ? "Создать новый ключ" : "Подтвердить код",
                        isFill: true
                    )
                    .disabled(viewModel.resetCodeDigits.contains { $0.isEmpty } && !showSuccessMessage)
                    .opacity((viewModel.resetCodeDigits.contains { $0.isEmpty } && !showSuccessMessage) ? 0.6 : 1.0)
                    
                    DefaultButton(
                        action: {
                            viewModel.resendCode()
                        },
                        buttonTitle: "Отправить код еще раз",
                        isFill: false
                    )
                    
                    DefaultButton(
                        action: {
                            viewModel.goBack()
                        },
                        buttonTitle: "Назад",
                        isFill: false
                    )
                }
            }
            .padding(20)
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            focusedField = nil
        }
        .onReceive(viewModel.$verificationSuccess) { success in
            if success {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSuccessMessage = true
                }
            }
        }
        .toast(
            isShowing: $viewModel.showNotification,
            message: viewModel.notificationMessage,
            type: viewModel.notificationType
        )
    }
} 