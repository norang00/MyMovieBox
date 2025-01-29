//
//  MainViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    
    var recentSearchList: [String] = ["aa", "bb", "cc"]
    var todayMovieList: [Movie] = []
    let dispatchGroup = DispatchGroup()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation("My Movie Box")
        
        configureProfileCard()
        configureRecentSearchWords()
        configureCollectionView()
        
        getTodayMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadProfileCard()
    }
    
    override func configureNavigation(_ title: String) {
        super.configureNavigation(title)
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(pushToSearchView))
        self.navigationItem.rightBarButtonItem = searchButton
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
        
        if recentSearchList.isEmpty {
            mainView.recentSearchEmptyView.isHidden = false
            
        } else {
            mainView.recentSearchEmptyView.isHidden = true
            
            for index in 0..<recentSearchList.count {
                let button = SearchWordSegment(frame: .zero)
                button.searchButton.setTitle(recentSearchList[index], for: .normal)
                button.searchButton.tag = index
                button.searchButton.addTarget(self, action: #selector(pushToSearchView), for: .touchUpInside)
                button.xButton.tag = index
                button.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)

                mainView.recentSearchStackView.addArrangedSubview(button)
            }

        }
    }
    
    @objc
    func xButtonTapped(_ sender: UIButton) {
        print(#function)
        // 검색어 삭제 및 버튼 재정렬
    }
    
    @objc
    func deleteAllButtonTapped() {
        
    }
    
    @objc
    func pushToSearchView(_ sender: UIButton) {
        print(#function, sender.tag)
        
        // 검색뷰로 이동
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
}

// MARK: - Today's Movie
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.identifier, for: indexPath) as! TodayMovieCollectionViewCell
        let movie = todayMovieList[indexPath.item]
        cell.configureData(movie, false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        let detailVC = DetailViewController()
        detailVC.movie = todayMovieList[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }

// TODO : Like 관리
//    func checkMovieLiked() {
//        
//    }
}

// MARK: - Network
extension MainViewController {
    
    private func getTodayMovie() {
        dispatchGroup.enter()
        NetworkManager.shared.callRequest(.trending, Trending.self) { Result in
            self.todayMovieList = Result.results
            self.dispatchGroup.leave()
        } failureHandler: { errorMessage in
            self.showAlert(title: "이런! 문제가 발생했어요", message: errorMessage)
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.mainView.collectionView.reloadData()
        }
    }
}
