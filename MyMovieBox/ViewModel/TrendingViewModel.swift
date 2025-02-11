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
    
    // [고민] Result 타입과 String 타입의 에러메세지를 함께 주려고 하는데 success 에서는 필요하지 않은 값이라 이렇게 전달하는게 맞는지 고민된다. 그렇다고 여기에서 에러 분기처리 (네트워크 매니저의 영역이라고 생각하기 때문에) 를 해주고 싶지는 않은데.
    private func getTrendingMovie() {
        NetworkManager.shared.callRequest(.trending, Trending.self) { [weak self] response, errorMessage in
            switch response {
            case .success(let value):
                self?.output.trendingList.value = value.results
            case .failure(_):
                guard let errorMessage = errorMessage else { return }
                let alert = AlertSet(title: Title.warning.rawValue, message: errorMessage)
                self?.output.showAlert.value = alert
                return
            }
        }
    }
}
