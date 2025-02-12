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
    
    // MARK: - ViewLifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation(Resources.Title.mainNav.rawValue)
        configureProfileCard()
        configureCollectionView()
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateProfileCard()
        updateLikeButtons()
    }
    
    // MARK: - bindAction
    private func bindAction() {
        mainView.profileCard.overlayButton.addTarget(self, action: #selector(profileCardTapped), for: .touchUpInside)
    }
    
    // MARK: - bindData
    private func bindData() {
        // Profile View
        profileViewModel.output.updateUserInfo.lazyBind { [weak self] _ in
            self?.updateProfileCard()
        }
        
        profileViewModel.output.presentUserSettingModal.lazyBind { [weak self] _ in
            self?.presentUserSettingModal()
        }
        
        // Trending View
        trendingViewModel.output.trendingList.lazyBind { [weak self] movieList in
            self?.mainView.collectionView.reloadData()
        }
        
        trendingViewModel.output.showAlert.lazyBind { [weak self] alertSet in
            guard let alertSet = alertSet else { return }
            self?.showAlert(title: alertSet.title, message: alertSet.message)
        }
        
        trendingViewModel.output.pushToDetailVC.lazyBind { [weak self] movie in
            guard let movie = movie else { return }
            self?.pushToDetailView(movie)
        }
        
        trendingViewModel.output.updateLike.lazyBind { [weak self] _ in
            self?.mainView.profileCard.movieBoxLabel.text = User.movieBoxLabel
        }
    }
    
    // MARK: - Search
    override func configureNavigation(_ title: String) {
        super.configureNavigation(title)
        
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: Resources.ImageName.search.rawValue),
            style: .plain, target: self, action: #selector(pushToSearchView))
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
        mainView.profileCard.overlayButton.addTarget(self, action: #selector(profileCardTapped), for: .touchUpInside)
    }
    
    @objc
    func profileCardTapped() {
        profileViewModel.input.profileCardTapped.value = ()
    }
    
    // [고민] View 에서 User 를 갖고 오는게 이게 맞나? 나름 저장소인데... 뷰모델에서 UserDefaults 정보 가지고 오고 또 그걸 별도 구조체에 포장해서 전달해줘야 하나?
    // 유용성 <-> 구조화
    func updateProfileCard() {
        mainView.profileCard.profileImageView.image = UIImage(named: User.profileImageName)
        mainView.profileCard.nicknameLabel.text = User.nickname
        mainView.profileCard.SignupDateLabel.text = User.signUpDate
        mainView.profileCard.movieBoxLabel.text = User.movieBoxLabel
    }
    
    func presentUserSettingModal() {
        let nicknameVC = NicknameSettingViewController()
        nicknameVC.isNewUser = false
        let nextVC = UINavigationController(rootViewController: nicknameVC)
        present(nextVC, animated: true)
    }
}

// MARK: - Trending
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
        let movie = trendingViewModel.output.trendingList.value[indexPath.item]
        trendingViewModel.input.movieTapped.value = movie
    }
    
    private func pushToDetailView(_ movie: Movie) {
        let detailVC = DetailViewController()
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Like
extension MainViewController {
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        let movieID = trendingViewModel.output.trendingList.value[sender.tag].id
        trendingViewModel.input.likeTapped.value = movieID
    }
    
    // [고민] 셀을 돌면서 좋아요 표시를 갱신해야 하는데 이건 뷰역할이 맞지 않나 싶은데 코드가 너무 복잡하당
    func updateLikeButtons() {
        let trendingList = trendingViewModel.output.trendingList.value
        let userLikedMovies = User.likedMovies
        for index in 0..<trendingList.count {
            let movie = trendingList[index]
            let cell = mainView.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TrendingCollectionViewCell
            cell?.likeButton.isSelected = userLikedMovies.contains(movie.id)
        }
    }
}
