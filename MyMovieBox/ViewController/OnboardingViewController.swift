//
//  OnboardingViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let onboardingView = OnboardingView()
    
    override func loadView() {
        view = onboardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("OnboardingViewController")
        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
    }
    
    @objc
    func startButtonTapped() {
        guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let window = windowsScene.windows.first
        window?.rootViewController = UINavigationController(rootViewController: ProfileNicknameViewController())
        window?.makeKeyAndVisible()
    }

}
