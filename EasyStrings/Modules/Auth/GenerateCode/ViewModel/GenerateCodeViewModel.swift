//
//  GenerateCodeViewModel.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import Foundation
import UIKit

class GenerateCodeViewModel: ObservableObject {
    
    private weak var router: AuthRouter?
    
    @Published var generatedCode: [String] = Array(repeating: "", count: 6)
    @Published var isGenerating = false
    @Published var showCopyNotification = false
    
    init(router: AuthRouter? = nil) {
        self.router = router
    }
    
    func generateCode() {
        isGenerating = true
        
        // Имитация задержки генерации
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.generateRandomCode()
            self.isGenerating = false
        }
    }
    
    func generateNewCode() {
        isGenerating = true
        
        // Очищаем предыдущий код
        generatedCode = Array(repeating: "", count: 6)
        
        // Имитация задержки генерации
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.generateRandomCode()
            self.isGenerating = false
        }
    }
    
    private func generateRandomCode() {
        let digits = "0123456789"
        var newCode: [String] = []
        
        for _ in 0..<6 {
            let randomDigit = String(digits.randomElement()!)
            newCode.append(randomDigit)
        }
        
        generatedCode = newCode
    }
    
    func copyCode() {
        let codeString = generatedCode.joined()
        UIPasteboard.general.string = codeString
        
        showCopyNotification = true
    }
    
    func goBack() {
        router?.popVC()
    }
} 