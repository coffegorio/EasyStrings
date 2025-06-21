//
//  GenerateCodeView.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import SwiftUI

struct GenerateCodeView: View {
    @ObservedObject var viewModel: GenerateCodeViewModel
    @State private var isAnimating = false
    @State private var showGeneratedCode = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                DefaultLabel(text: "Генерация ключа", font: .title)
                DefaultLabel(text: "Создайте новый ключ-доступа для вашей учетной записи.")
                
                Spacer()
                
                // Анимированный контейнер для кода
                VStack(spacing: 20) {
                    if showGeneratedCode {
                        VStack(spacing: 15) {
                            DefaultLabel(text: "Ваш новый ключ:", font: .headline, alignment: .center)
                            
                            HStack(spacing: 8) {
                                ForEach(0..<6, id: \.self) { index in
                                    Text(viewModel.generatedCode[index])
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("AccentColor"))
                                        .frame(width: 45, height: 55)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                                        )
                                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                                        .animation(
                                            Animation.easeInOut(duration: 0.3)
                                                .delay(Double(index) * 0.1),
                                            value: isAnimating
                                        )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .transition(.opacity.combined(with: .scale))
                    } else {
                        // Плейсхолдер с анимацией загрузки
                        VStack(spacing: 15) {
                            DefaultLabel(text: "Генерация ключа...", font: .headline, alignment: .center)
                            
                            HStack(spacing: 8) {
                                ForEach(0..<6, id: \.self) { index in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 45, height: 55)
                                        .scaleEffect(isAnimating ? 0.8 : 1.0)
                                        .animation(
                                            Animation.easeInOut(duration: 0.6)
                                                .repeatForever()
                                                .delay(Double(index) * 0.1),
                                            value: isAnimating
                                        )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                .frame(height: 200)
                
                Spacer()
                
                VStack(spacing: 15) {
                    DefaultButton(
                        action: {
                            if showGeneratedCode {
                                viewModel.copyCode()
                            } else {
                                viewModel.generateCode()
                            }
                        },
                        buttonTitle: showGeneratedCode ? "Скопировать ключ" : "Сгенерировать",
                        isFill: true
                    )
                    
                    if showGeneratedCode {
                        DefaultButton(
                            action: {
                                viewModel.generateNewCode()
                            },
                            buttonTitle: "Сгенерировать новый",
                            isFill: false
                        )
                    }
                    
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
        .onAppear {
            isAnimating = true
        }
        .onReceive(viewModel.$generatedCode) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                showGeneratedCode = !viewModel.generatedCode.allSatisfy { $0.isEmpty }
            }
        }
        .toast(
            isShowing: $viewModel.showCopyNotification,
            message: "Ключ скопирован в буфер обмена",
            type: .success
        )
    }
} 