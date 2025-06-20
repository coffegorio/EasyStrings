//
//  SceneDelegate.swift
//  EasyStrings
//
//  Created by Егорио on 19.06.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var router: PreviewRouter?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        self.router = PreviewRouter(navigationController: navigationController)
        self.router?.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()     
    }
}

