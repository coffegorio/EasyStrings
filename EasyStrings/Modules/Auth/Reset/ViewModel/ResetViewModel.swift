//
//  ResetViewModel.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import Foundation

class ResetViewModel: ObservableObject {
    
    private weak var router: AuthRouter?
    
    @Published var email = ""
    @Published var emailError = ""
    @Published var isEmailValid = false
    @Published var resetSuccess = false
    @Published var isLoading = false
    
    init(router: AuthRouter? = nil) {
        self.router = router
    }
    
    func validateEmail() {
        emailError = ""
        
        if email.isEmpty {
            isEmailValid = false
            return
        }
        
        // Простая валидация email
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            emailError = "Введите корректный email адрес"
            isEmailValid = false
        } else {
            isEmailValid = true
        }
    }
    
    func sendResetInstructions() {
        guard isEmailValid else { return }
        
        isLoading = true
        
        // Имитация отправки запроса на сервер
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isLoading = false
            self.resetSuccess = true
            
            // Переходим к экрану ввода кода подтверждения
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.router?.showResetCode(email: self.email)
            }
        }
    }
    
    func resetForm() {
        email = ""
        emailError = ""
        isEmailValid = false
        resetSuccess = false
    }
    
    func goBack() {
        router?.popVC()
    }
    
    private func sendResetRequest() {
        // Здесь должна быть реальная логика отправки запроса на сервер
        // Например:
        /*
        let parameters = ["email": email]
        
        // Отправка POST запроса
        // Обработка ответа
        // Обновление UI в зависимости от результата
        */
    }
} 