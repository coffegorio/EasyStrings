//
//  Router.swift
//  EasyStrings
//
//  Created by Егорио on 19.06.2025.
//

import UIKit
    
protocol MainRouter {
    
    var navigationController: UINavigationController { get }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool)
    func presentViewController(_ viewController: UIViewController, animated: Bool)
    func dismissViewController(animated: Bool)
    
}

class BaseRouter: MainRouter {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func popViewController(animated: Bool) {
        navigationController.popViewController(animated: true)
    }
    
    func presentViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: true)
    }
    
    func dismissViewController(animated: Bool) {
        navigationController.dismiss(animated: true)
    }
    
}
