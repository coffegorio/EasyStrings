//
//  AuthRouter.swift
//  EasyStrings
//
//  Created by Егорио on 20.06.2025.
//

import UIKit

class AuthRouter: BaseRouter {
    
    func showSignIn() {
        let viewController = SignInViewController()
        let viewModel = SignInViewModel(router: self)
        viewController.viewModel = viewModel
        pushViewController(viewController, animated: true)
    }
    
    func showSignUp() {
        // пока что пусто 
    }
    
    func showReset() {
        // пока что пусто
    }
    
    func popVC() {
        popViewController(animated: true)
    }
    
}
