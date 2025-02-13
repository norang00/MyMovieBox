//
//  DetailViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/29/25.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    let detailViewModel = DetailViewModel()
    
    var backdropList: [Backdrop] = []
    var posterList: [Poster] = []
    var castList: [Cast] = []
    var currentPage: Int = 0 {
        didSet {
            detailView.backdropPageControl.currentPage = currentPage
        }
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        bindData()
    }
    
    // MARK: - bindData
    private func bindData() {
        detailViewModel.output.movie.bind { [weak self] movie in
            guard let movie = movie else { return }
            self?.configureNavigation(movie)
        }

        // [TODO] View 에 구현해 놓은 함수도 옮겨오는게 좋을까?
        detailViewModel.output.movieDescription.bind { [weak self] list in
            self?.detailView.movieDescriptionLabel.attributedText = self?.detailView.setMovieDescription(list[0], list[1], list[2])
        }
        
        detailViewModel.output.movieSynopsis.bind { [weak self] synopsis in
            guard let synopsis = synopsis else { return }
            if synopsis.isEmpty {
                self?.detailView.synopsisButton.isHidden = true
            } else {
                self?.detailView.synopsisContentLabel.text = synopsis
                self?.detailView.synopsisButton.isHidden = false
                self?.detailView.synopsisButton.addTarget(self, action: #selector(self?.synopsisButtonTapped), for: .touchUpInside)
            }
        }
        
        detailViewModel.output.backdropList.bind { [weak self] list in
            self?.backdropList = list
            self?.detailView.backdropCollectionView.reloadData()
            self?.configurePageControl()
        }
        
        detailViewModel.output.castList.bind { [weak self] list in
            self?.castList = list
            self?.detailView.castCollectionView.reloadData()
        }
        
        detailViewModel.output.posterList.bind { [weak self] list in
            self?.posterList = list
            self?.detailView.posterCollectionView.reloadData()
        }
        
        detailViewModel.output.toggleLike.lazyBind { [weak self] _ in
                guard let likeButton = self?.navigationItem.rightBarButtonItem?.customView as? LikeButton else { return }
                likeButton.isSelected.toggle()
            }
        
    }
    
    // MARK: - configureNavigation
    func configureNavigation(_ movie: Movie) {
        navigationItem.title = movie.title
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .accent
        
        let likeButton = LikeButton()
        likeButton.isSelected = User.checkLike(movie.id)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
    }
}

// MARK: - CollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    // [TODO] delegate 위치 고민해보기
    func configureCollectionView() {
        detailView.backdropCollectionView.delegate = self
        detailView.backdropCollectionView.dataSource = self
        detailView.backdropCollectionView.tag = 0
        
        detailView.castCollectionView.delegate = self
        detailView.castCollectionView.dataSource = self
        detailView.castCollectionView.tag = 1

        detailView.posterCollectionView.delegate = self
        detailView.posterCollectionView.dataSource = self
        detailView.posterCollectionView.tag = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return backdropList.count
        case 1:
            return castList.count
        case 2:
            return posterList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.identifier,
                                                          for: indexPath) as! BackdropCollectionViewCell
            cell.configureData(backdropList[indexPath.item].filePath)
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier,
                                                          for: indexPath) as! CastCollectionViewCell
            cell.configureData(castList[indexPath.item])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier,
                                                          for: indexPath) as! PosterCollectionViewCell
            cell.configureData(posterList[indexPath.item].filePath)
            return cell
        default:
            let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0))!
            return cell
        }
    }
}

// MARK: - Page Control
extension DetailViewController {
    func configurePageControl() {
        detailView.backdropPageControl.numberOfPages = backdropList.count
    }
    
    // [고민] 이거는 어떻게 옮겨주지?
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == detailView.backdropCollectionView {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x/width)
        }
    }
}

// MARK: - Synopsis
extension DetailViewController {
    @objc
    func synopsisButtonTapped() {
        let button = detailView.synopsisButton
        button.isSelected.toggle()
        detailView.synopsisButton.setTitle(button.isSelected ? Resources.Title.hide.rawValue : Resources.Title.more.rawValue, for: .normal)
        detailView.synopsisContentLabel.numberOfLines = button.isSelected ? 0 : 3
    }
}

// MARK: - Like
extension DetailViewController {
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        detailViewModel.input.likeButtonTapped.value = ()
    }
}
