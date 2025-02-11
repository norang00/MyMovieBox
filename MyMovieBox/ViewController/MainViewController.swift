//
//  MainViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit

final class MainViewController: BaseViewController {
    
    private let mainView = MainView()
    private let profileViewModel = ProfileViewModel()
    private let trendingViewModel = TrendingViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation(Title.mainNav.rawValue)
        configureCollectionView()
        
        bindAction()
        bindData()
    }
    
    private func bindAction() {
        mainView.profileCard.overlayButton.addTarget(self, action: #selector(profileCardTapped), for: .touchUpInside)
    }
    
    private func bindData() {
        profileViewModel.output.userInfo.bind { [weak self] _ in
            self?.mainView.profileCard.profileImageView.image = UIImage(named: User.profileImageName)
            self?.mainView.profileCard.nicknameLabel.text = User.nickname
            self?.mainView.profileCard.SignupDateLabel.text = User.signUpDate
            self?.mainView.profileCard.movieBoxLabel.text = User.movieBoxLabel
        }
        
        profileViewModel.output.presentUserSettingModal.lazyBind { [weak self] _ in
            self?.presentUserSettingModal()
        }
        
        trendingViewModel.output.trendingList.bind { [weak self] movieList in
            self?.mainView.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
    
    @objc
    func profileCardTapped() {
        profileViewModel.input.profileCardTapped.value = ()
    }
    
    func presentUserSettingModal() {
        let nicknameVC = NicknameSettingViewController()
        nicknameVC.isNewUser = false
        nicknameVC.editingDone = {
//            self.configureProfileCard()
        }
        let nextVC = UINavigationController(rootViewController: nicknameVC)
        present(nextVC, animated: true)
    }
}

// MARK: - Trending Movie
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let trendingList = trendingViewModel.output.trendingList.value
        return trendingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell

        let trendingList = trendingViewModel.output.trendingList.value
        let movie = trendingList[indexPath.item]
        cell.configureData(movie, User.checkLike(movie.id))

        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.likeButton.tag = indexPath.item

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let trendingList = trendingViewModel.output.trendingList.value
        let detailVC = DetailViewController()
        detailVC.movie = trendingList[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: 좋아요 기능
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        let trendingList = trendingViewModel.output.trendingList.value

        let movie = trendingList[sender.tag]
        User.toggleLike(movie)
        sender.isSelected.toggle()
        mainView.profileCard.movieBoxLabel.text = "\(User.likedMovies.count)"+Title.likedMovie.rawValue
    }
    
    func reloadLike() {
        let trendingList = trendingViewModel.output.trendingList.value

        let userLikedMovies = User.likedMovies
        for index in 0..<trendingList.count {
            let movie = trendingList[index]
            let cell = mainView.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TrendingCollectionViewCell
            cell?.likeButton.isSelected = userLikedMovies.contains(movie.id)
        }
    }
}
