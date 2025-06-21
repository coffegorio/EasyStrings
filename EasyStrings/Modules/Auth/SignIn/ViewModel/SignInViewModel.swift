//
//  SignInViewModel.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    private weak var router: AuthRouter?
    
    @Published var authKeyDigits: [String] = Array(repeating: "", count: 6)
    
    init(router: AuthRouter? = nil) {
        self.router = router
    }
    
    func signIn() {
        let authKey = authKeyDigits.joined()
        
        // Проверяем, что все поля заполнены
        guard authKey.count == 6 else {
            // Можно добавить уведомление об ошибке
            return
        }
        
        // Здесь должна быть логика проверки ключа на сервере
        // Пока что просто имитируем успешный вход
        print("Попытка входа с ключом: \(authKey)")
        
        // После успешной проверки можно перейти к основному экрану
        router?.showMainScreen()
    }
    
    func generateKey() {
        router?.showGenerateCode()
    }
    
    func resetAccess() {
        router?.showReset()
    }

}
