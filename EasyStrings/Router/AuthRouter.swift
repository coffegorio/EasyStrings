//
//  AuthRouter.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import UIKit
import SwiftUI

class AuthRouter: BaseRouter {
    
    func showSignIn() {
        let viewModel = SignInViewModel(router: self)
        let view = SignInView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        pushViewController(hostingController, animated: true)
    }
    
    func showSignUp() {
        // пока что пусто 
    }
    
    func showReset() {
        let viewModel = ResetViewModel(router: self)
        let view = ResetView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        pushViewController(hostingController, animated: true)
    }
    
    func showResetCode(email: String) {
        let viewModel = ResetCodeViewModel(router: self, email: email)
        let view = ResetCodeView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        pushViewController(hostingController, animated: true)
    }
    
    func showGenerateCode() {
        let viewModel = GenerateCodeViewModel(router: self)
        let view = GenerateCodeView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        pushViewController(hostingController, animated: true)
    }
    
    func showMainScreen() {
        // тут будет логика перехода на главный экран
        print("переход на главный экран")
    }
    
    func popVC() {
        popViewController(animated: true)
    }
    
}
