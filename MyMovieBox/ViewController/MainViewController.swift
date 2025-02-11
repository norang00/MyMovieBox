//
//  MainViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    var todayMovieList: [Movie] = []
    let dispatchGroup = DispatchGroup()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation(Title.mainNav.rawValue)
        configureCollectionView()
        
        getTodayMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureProfileCard()
        reloadLike()
    }
    
    override func configureNavigation(_ title: String) {
        super.configureNavigation(title)
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: ImageName.search.rawValue), style: .plain, target: self, action: #selector(pushToSearchView))
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc
    func pushToSearchView() {
        let nextVC = SearchViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Profile
extension MainViewController {
    
    func configureProfileCard() {
        mainView.profileCard.profileImageView.image = UIImage(named: User.profileImageName)
        mainView.profileCard.nicknameLabel.text = User.nickname
        mainView.profileCard.movieBoxLabel.text = "\(User.likedMovies.count)"+Title.likedMovie.rawValue
        mainView.profileCard.overlayButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
    }
    
    @objc func profileTapped() {
        let nicknameVC = NicknameSettingViewController()
        nicknameVC.isNewUser = false
        nicknameVC.editingDone = {
            self.configureProfileCard()
        }
        let nextVC = UINavigationController(rootViewController: nicknameVC)
        present(nextVC, animated: true)
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
        let detailVC = DetailViewController()
        detailVC.movie = todayMovieList[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: 좋아요 기능
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        let movie = todayMovieList[sender.tag]
        User.toggleLike(movie)
        sender.isSelected.toggle()
        mainView.profileCard.movieBoxLabel.text = "\(User.likedMovies.count)"+Title.likedMovie.rawValue
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
            self.showAlert(title: Title.warning.rawValue, message: errorMessage)
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.mainView.collectionView.reloadData()
        }
    }
}
