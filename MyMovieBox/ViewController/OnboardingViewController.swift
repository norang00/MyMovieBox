//
//  OnboardingViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    private let onboardingView = OnboardingView()
    
    override func loadView() {
        view = onboardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func startButtonTapped() {
        let nextVC = NicknameSettingViewController()
        nextVC.isNewUser = true
        navigationController?.pushViewController(nextVC, animated: true)        
    }
}
