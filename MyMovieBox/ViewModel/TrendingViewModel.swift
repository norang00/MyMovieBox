//
//  TrendingViewModel.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 2/11/25.
//

import Foundation

final class TrendingViewModel: BaseViewModel {

    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let viewLoaded: Observable<Void?> = Observable(nil)
        let movieTapped: Observable<Movie?> = Observable(nil)
        let likeTapped: Observable<Int?> = Observable(nil)
    }
    
    struct Output {
        let trendingList: Observable<[Movie]> = Observable([])
        let showAlert: Observable<AlertSet?> = Observable(nil)
        let pushToDetailVC: Observable<Movie?> = Observable(nil)
        let updateLike: Observable<Void?> = Observable(nil)
    }
        
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.viewLoaded.bind { [weak self] _ in
            self?.getTrendingMovie()
        }
        
        input.movieTapped.lazyBind { [weak self] movie in
            guard let movie = movie else { return }
            self?.output.pushToDetailVC.value = movie
        }
        
        input.likeTapped.lazyBind { [weak self] movieID in
            guard let movieID = movieID else { return }
            self?.toggleLike(movieID)
        }
    }
}

// MARK: - Like
extension TrendingViewModel {
    
    private func toggleLike(_ movieID: Int) {
        User.toggleLike(movieID)
        output.updateLike.value = ()
    }
}

// MARK: - Network
extension TrendingViewModel {
    
    private func getTrendingMovie() {
        NetworkManager.shared.callRequest(.trending, Trending.self) { [weak self] response in
            switch response {
            case .success(let value):
                self?.output.trendingList.value = value.results
            case .failure(let error):
                let alert = AlertSet(title: Resources.Alert.Title.warning.rawValue,
                                     message: error.rawValue)
                self?.output.showAlert.value = alert
            }
        }
    }
}
