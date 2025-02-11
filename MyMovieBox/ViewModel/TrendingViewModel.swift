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
        let viewLoaded: Observable<Void?> = Observable(nil) // [고민] load 자체를 input 으로 보는게 맞나?
        let movieTapped: Observable<Movie?> = Observable(nil)
        let likeTapped: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        let trendingList: Observable<[Movie]> = Observable([])
        let showAlert: Observable<AlertSet?> = Observable(nil)
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
                let errorMessage = error.localizedDescription
                let alert = AlertSet(title: Title.warning.rawValue, message: errorMessage)
                self?.output.showAlert.value = alert
                return
            }
        }
    }
}
