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
    
    var searchList: [String] = ["aa", "bb", "cc"]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation("My Movie Box")
        
        configureRecentSearchWords()
        
        
        
        mainView.profileCard.overlayButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        mainView.tempButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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

// MARK: - Recent Search
extension MainViewController {
    
    func configureRecentSearchWords() {
//       searchList = User.recentSearch
        
        if searchList.isEmpty {
            mainView.recentSearchEmptyView.isHidden = false
            
        } else {
            mainView.recentSearchEmptyView.isHidden = true
            
            for index in 0..<searchList.count {
                print(#function, index)
                let button = SearchWordSegment(frame: .zero)
                button.searchButton.setTitle(searchList[index], for: .normal)
                button.searchButton.tag = index
                button.searchButton.addTarget(self, action: #selector(wordButtonTapped), for: .touchUpInside)
                button.xButton.tag = index
                button.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)

                mainView.recentSearchStackView.addArrangedSubview(button)
            }

        }
    }
    
    @objc
    func wordButtonTapped(_ sender: UIButton) {
        print(#function)
        // 검색뷰로 이동
    }
    
    @objc
    func xButtonTapped(_ sender: UIButton) {
        print(#function)
        // 검색어 삭제 및 버튼 재정렬
    }
    
    @objc
    func deleteAllButtonTapped() {
        
    }
    
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
