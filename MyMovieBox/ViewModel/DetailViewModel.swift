//
//  DetailViewModel.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 2/12/25.
//

import Foundation

final class DetailViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output

    var backdropList: [Backdrop] = []
    var posterList: [Poster] = []
    var castList: [Cast] = []

    struct Input {
        let movie: Observable<Movie?> = Observable(nil)
        let likeButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let movie: Observable<Movie?> = Observable(nil)
        let movieDescription: Observable<[String]> = Observable([])
        let movieSynopsis: Observable<String?> = Observable(nil)
        let backdropList: Observable<[Backdrop]> = Observable([])
        let castList: Observable<[Cast]> = Observable([])
        let posterList: Observable<[Poster]> = Observable([])
        let toggleLike: Observable<Void?> = Observable(nil)
        let showAlert: Observable<AlertSet?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        
        input.movie.bind { [weak self] movie in
            guard let movie = movie else { return }
            self?.output.movie.value = movie
            self?.setMovieDescription(movie)
            self?.setMovieSynopsis(movie)
            self?.getData(movie)
        }
                
        input.likeButtonTapped.lazyBind { [weak self] _ in
            guard let movie = self?.output.movie.value else { return }
            self?.output.toggleLike.value = ()
            self?.toggleLike(movie.id)
        }
        
    }
    
    private func setMovieDescription(_ movie: Movie) {
        let releaseDate: String = movie.releaseDate ?? "-"
        let voteAverage: String = String(format: "%.1f", movie.voteAverage ?? 0.0)
        let genres: String = getGenreString(movie)
        output.movieDescription.value = [releaseDate, voteAverage, genres]
    }
    
    private func getGenreString(_ movie: Movie) -> String {
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
    
    private func setMovieSynopsis(_ movie: Movie) {
        guard let synopsis = movie.overview else { return }
        output.movieSynopsis.value = synopsis
    }
}

// MARK: - Like
// [TODO] 중복관리하기
extension DetailViewModel {
    private func toggleLike(_ movieID: Int) {
        User.toggleLike(movieID)
    }
}

// MARK: - Network
extension DetailViewModel {
    
    private func getData(_ movie: Movie) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkManager.shared.callRequest(.image(query: movie.id), Image.self) { [weak self] response in
            switch response {
            case .success(let value):
                self?.backdropList = value.backdrops.count > 5 ? Array(value.backdrops.prefix(5)) : value.backdrops
                self?.posterList = value.posters
                dispatchGroup.leave()
            case .failure(let error):
                let alert = AlertSet(title: Resources.Alert.Title.warning.rawValue,
                                     message: error.rawValue)
                self?.output.showAlert.value = alert
            }
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.callRequest(.credit(query: movie.id), Credit.self) { [weak self] response in
            switch response {
            case .success(let value):
                self?.castList = value.cast
                dispatchGroup.leave()
            case .failure(let error):
                let alert = AlertSet(title:  Resources.Alert.Title.warning.rawValue,
                                     message: error.rawValue)
                self?.output.showAlert.value = alert
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.output.backdropList.value = self.backdropList
            self.output.posterList.value = self.posterList
            self.output.castList.value = self.castList
        }
    }
}
