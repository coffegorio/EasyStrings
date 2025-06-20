//
//  PreviewViewController.swift
//  EasyStrings
//
//  Created by Егорио on 19.06.2025.
//

import UIKit
import Lottie

class PreviewViewController: UIViewController {
    
    var viewModel: PreviewViewModel?
    
    lazy private var lottieView: LottieAnimationView = {
            $0.frame.size = CGSize(width: view.frame.width - 80, height: view.frame.width - 80)
            $0.center = view.center
            $0.loopMode = .loop
            return $0
        }(LottieAnimationView(name: "PreviewAnimation"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigateNextScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        lottieView.stop()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(lottieView)
        lottieView.play()
    }
    
    private func navigateNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel?.navigateNextScreen()
        }
    }
}
