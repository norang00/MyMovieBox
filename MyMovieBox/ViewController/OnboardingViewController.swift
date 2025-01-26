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
        navigationItem.title = ""

        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func startButtonTapped() {
        let nextVC = ProfileNicknameViewController()
        nextVC.isNewUser = true
        navigationController?.pushViewController(nextVC, animated: true)        
    }
}
