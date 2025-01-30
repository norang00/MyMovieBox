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
        reloadLike()
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
        cell.configureData(movie, User.checkLike(movie.id))
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.likeButton.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function, indexPath)
        let detailVC = DetailViewController()
        detailVC.movie = todayMovieList[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: 좋아요 기능
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        let movie = todayMovieList[sender.tag]

        if let index = User.likedMovies.firstIndex(of: movie.id) {
            User.likedMovies.remove(at: index)
        } else {
            User.likedMovies.append(movie.id)
        }

        sender.isSelected.toggle()
        mainView.collectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
    }
    
    func reloadLike() {
        let userLikedMovies = User.likedMovies
        for index in 0..<todayMovieList.count {
            let movie = todayMovieList[index]
            let cell = mainView.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TodayMovieCollectionViewCell
            cell?.likeButton.isSelected = userLikedMovies.contains(movie.id)
        }
    }
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
