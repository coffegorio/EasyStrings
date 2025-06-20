//
//  PreviewRouter.swift
//  EasyStrings
//
//  Created by Егорио on 19.06.2025.
//

import UIKit

class PreviewRouter: BaseRouter {
    
    func start() {
        showPreview()
    }
    
    func showPreview() {
        let viewController = PreviewViewController()
        let viewModel = PreviewViewModel(router: self)
        viewController.viewModel = viewModel
        pushViewController(viewController, animated: true)
    }
    
    func navigateToAuth() {
        let authRouter = AuthRouter(navigationController: navigationController)
        authRouter.showSignIn()
    }
    
}
