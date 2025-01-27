//
//  MainViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation("My Movie Box")
        
        
        
        
        
        mainView.tempButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        mainView.profileCard.overlayButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadProfileCard()
    }
    
}

// MARK: - Profile
extension MainViewController {
    
    
    
    
    @objc func profileTapped() {
        let nicknameVC = NicknameSettingViewController()
        nicknameVC.isNewUser = false
        
        let nextVC = UINavigationController(rootViewController: nicknameVC)
        present(nextVC, animated: true)
    }
    
    func reloadProfileCard() {
        mainView.profileCard.profileImageView.image = UIImage(named: User.profileImageName)
        mainView.profileCard.nicknameLabel.text = User.nickname
        mainView.profileCard.SignupDateLabel.text = User.signUpDate
        mainView.profileCard.likeLabel.text = "\(User.likedMovies.count)개의 무비박스 보관중"
    }
}

// MARK: - Latest Search
extension MainViewController {
    
    
}

// MARK: - Today's Movie
extension MainViewController {
    
    
}

// MARK: - temporary
extension MainViewController {
    
    @objc func buttonTapped() {
        User.reset()
        guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let window = windowsScene.windows.first
        window?.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        window?.makeKeyAndVisible()
    }
}
