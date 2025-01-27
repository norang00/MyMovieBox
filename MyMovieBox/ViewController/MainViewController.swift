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
        
        configureProfileCard()
        configureRecentSearchWords()
        configureCollectionView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadProfileCard()
    }
    
}

// MARK: - Profile
extension MainViewController {
 
    func configureProfileCard() {
        mainView.profileCard.overlayButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
    }
    
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

// MARK: - Recent Search // TODO: 레이아웃 조정중
extension MainViewController {
    
    func configureRecentSearchWords() {
//       searchList = User.recentSearch
        
        if searchList.isEmpty {
            mainView.recentSearchEmptyView.isHidden = false
            
        } else {
            mainView.recentSearchEmptyView.isHidden = true
            
            for index in 0..<searchList.count {
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
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.identifier, for: indexPath) as! TodayMovieCollectionViewCell
  
        
        
//        cell.configureData(<#T##movie: Movie##Movie#>, <#T##isLiked: Bool##Bool#>)
     
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
    }
    
}
