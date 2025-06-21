//
//  ResetCodeViewModel.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import Foundation

class ResetCodeViewModel: ObservableObject {
    
    private weak var router: AuthRouter?
    private let email: String
    
    @Published var resetCodeDigits: [String] = Array(repeating: "", count: 6)
    @Published var errorMessage = ""
    @Published var verificationSuccess = false
    @Published var showNotification = false
    @Published var notificationMessage = ""
    @Published var notificationType: ToastView.ToastType = .info
    @Published var isLoading = false
    
    init(router: AuthRouter? = nil, email: String) {
        self.router = router
        self.email = email
    }
    
    func verifyCode() {
        let code = resetCodeDigits.joined()
        
        guard code.count == 6 else {
            errorMessage = "Введите полный код"
            return
        }
        
        isLoading = true
        errorMessage = ""
        
        // Имитация проверки кода на сервере
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false
            
            // Для демонстрации считаем код "123456" правильным
            if code == "123456" {
                self.verificationSuccess = true
                self.showSuccessNotification()
            } else {
                self.errorMessage = "Неверный код. Попробуйте еще раз."
                self.showErrorNotification()
            }
        }
    }
    
    func resendCode() {
        isLoading = true
        
        // Имитация отправки нового кода
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isLoading = false
            self.resetCodeDigits = Array(repeating: "", count: 6)
            self.errorMessage = ""
            self.showInfoNotification(message: "Новый код отправлен на \(self.email)")
        }
    }
    
    func createNewKey() {
        router?.showGenerateCode()
    }
    
    func goBack() {
        router?.popVC()
    }
    
    private func showSuccessNotification() {
        notificationMessage = "Код подтвержден успешно!"
        notificationType = .success
        showNotification = true
    }
    
    private func showErrorNotification() {
        notificationMessage = "Ошибка при проверке кода"
        notificationType = .error
        showNotification = true
    }
    
    private func showInfoNotification(message: String) {
        notificationMessage = message
        notificationType = .info
        showNotification = true
    }
} 