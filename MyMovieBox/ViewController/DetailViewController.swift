//
//  DetailViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/29/25.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    let detailView = DetailView()
    var movie: Movie?

    var backdropList: [Backdrop] = []
    var currentPage: Int = 0 {
        didSet {
            detailView.backdropPageControl.currentPage = currentPage
        }
    }
    
    var castList: [Cast] = []
    
    var posterList: [Poster] = []
    
    let dispatchGroup = DispatchGroup()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation(movie!.title)
        configureCollectionView()
        configureMovieDescription()
        
        getData(movie!)
    }
    
    override func configureNavigation(_ title: String) {
        super.configureNavigation(title)
                
        let likeButton = LikeButton()
        likeButton.isSelected = User.checkLike(movie!.id)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)
    }
    
    // MARK: 좋아요 기능
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        User.toggleLike(movie!)
        sender.isSelected.toggle()
    }

}

// MARK: - CollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func configureCollectionView() {
        print(#function)
        detailView.backdropCollectionView.delegate = self
        detailView.backdropCollectionView.dataSource = self
        detailView.backdropCollectionView.tag = 0
        
//        detailView.castCollectionView.delegate = self
//        detailView.castCollectionView.dataSource = self
//        detailView.castCollectionView.tag = 1
//
//        detailView.posterCollectionView.delegate = self
//        detailView.posterCollectionView.dataSource = self
//        detailView.posterCollectionView.tag = 2
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
//        switch collectionView.tag {
//        case 0:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.identifier,
                                                      for: indexPath) as! BackdropCollectionViewCell
        cell.configureData(backdropList[indexPath.item].filePath)
        
        print(#function, backdropList[indexPath.item].filePath)
        return cell
//        case 1:
//            return castList.count
//        case 2:
//            return posterList.count
//        default:
//            return 0
//        }
    }
}

// MARK: - (BackdropCollectionView) PageControl
extension DetailViewController {

    func configurePageControl() {
        detailView.backdropPageControl.numberOfPages = backdropList.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == detailView.backdropCollectionView {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x/width)
        }
    }
}

// MARK: - Movie Description (개봉일, 평점, 장르)
extension DetailViewController {

    func configureMovieDescription() {
        guard let movie = movie else { return }
        
        let releaseDate: String = movie.releaseDate ?? "-"
        let voteAverage: String = String(format: "%.1f", movie.voteAverage ?? 0.0)
        let genres: String = getGenreString(movie)
        
        detailView.movieDescriptionLabel.attributedText = detailView.setMovieDescription(releaseDate, voteAverage, genres)
    }
    
    func getGenreString(_ movie: Movie) -> String {
        let genres = movie.genreIds ?? []
        var returnString = ""

        if genres.isEmpty {
            returnString = "-"
        } else if genres.count == 1 {
            if let genre = Genre.mapping[genres[0]] {
                returnString = genre
            }
        } else {
            guard let genre0 = Genre.mapping[genres[0]] else { return "" }
            returnString = "\(genre0), "
            guard let genre1 = Genre.mapping[genres[1]] else { return "" }
            returnString += genre1
        }
        return returnString
    }
}

// MARK: - Network
extension DetailViewController {
    
    func getData(_ movie: Movie) {
        print(#function, movie.id, movie.title)
        dispatchGroup.enter()
        NetworkManager.shared.callRequest(.image(query: movie.id), Image.self) { Result in
            self.backdropList = Result.backdrops.count > 5 ? Array(Result.backdrops.prefix(5)) : Result.backdrops
            self.posterList = Result.posters
            
            print(#function, self.backdropList)
            self.dispatchGroup.leave()
        } failureHandler: { errorMessage in
            self.showAlert(title: "이런! 문제가 발생했어요", message: errorMessage)
            self.dispatchGroup.leave()
        }
        
//        dispatchGroup.enter()
//        NetworkManager.shared.callRequest(.credit(query: movie.id), Credit.self) { Result in
//            self.castList = Result.cast
//            self.dispatchGroup.leave()
//        } failureHandler: { errorMessage in
//            self.showAlert(title: "이런! 문제가 발생했어요", message: errorMessage)
//            self.dispatchGroup.leave()
//        }
        
        dispatchGroup.notify(queue: .main) {
            print(#function, "dispatchGroup.notify")

            self.detailView.backdropCollectionView.reloadData()
            self.configurePageControl()

//            self.detailView.castCollectionView.reloadData()
//            self.detailView.posterCollectionView.reloadData()
        }
    }
}
