//
//  PreviewViewModel.swift
//  EasyStrings
//
//  Created by Егорио on 19.06.2025.
//

import UIKit

class PreviewViewModel {
    private weak var router: PreviewRouter?

    init(router: PreviewRouter? = nil) {
        self.router = router
    }
    
    func navigateNextScreen() {
        // тут я скорее всего добавлю проверку, если пользователь уже авторизован - он будет попадать на mainscreen, но пока что так
        self.router?.navigateToAuth()
    }
}
