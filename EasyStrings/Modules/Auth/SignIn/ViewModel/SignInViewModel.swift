//
//  SignInViewModel.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import Foundation

class SignInViewModel {
    private weak var router: AuthRouter?
    
    init(router: AuthRouter? = nil) {
        self.router = router
    }
}
