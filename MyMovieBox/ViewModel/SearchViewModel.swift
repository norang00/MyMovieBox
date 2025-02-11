//
//  SearchViewModel.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 2/11/25.
//

import Foundation

final class SearchViewModel: BaseViewModel {

    private(set) var input: Input
    private(set) var output: Output
    
    // internal properties
    private var totalPage = 0
    private var page = 1
    private var previousQuery = ""
    private var currentQuery = ""
//    private var recentList: [Int] = []
    private var resultResult: [Movie] = []
    private var dispatchGroup = DispatchGroup()

    struct Input {
        let viewLoaded: Observable<Void?> = Observable(nil)
        let searchButtonTapped: Observable<String?> = Observable(nil)
        let recentButtonTapped: Observable<String?> = Observable(nil)
        let recentXButtonTapped: Observable<Int?> = Observable(nil)
        let recentDeleteTapped: Observable<Void?> = Observable(nil)
        let movieRowTapped: Observable<Movie?> = Observable(nil)
        let loadAdditionalPage: Observable<[IndexPath]> = Observable([])
    }
    
    struct Output {
        let recentList: Observable<[String]> = Observable([])
        let resultList: Observable<[Movie]> = Observable([])
        let showRecentView: Observable<Void?> = Observable(nil)
        let showResultView: Observable<Void?> = Observable(nil) // 어디까지 지정해야..?
        let reloadRecentView: Observable<Void?> = Observable(nil)
        let reloadResultView: Observable<Void?> = Observable(nil)
        let scrollResultView: Observable<Void?> = Observable(nil)
        let becomeResponder: Observable<Void?> = Observable(nil)
        let resignResponder: Observable<Void?> = Observable(nil)
        let pushToDetailVC: Observable<Movie?> = Observable(nil)
        let updateLike: Observable<Void?> = Observable(nil)
        let showAlert: Observable<AlertSet?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.viewLoaded.bind { [weak self] _ in
            self?.output.becomeResponder.value = ()
            self?.output.recentList.value = User.recentSearch
        }
        
        input.searchButtonTapped.lazyBind { [weak self] inputText in
            guard let inputText = inputText else { return }
            self?.getSearchResult(inputText)
        }

        input.recentXButtonTapped.lazyBind { [weak self] index in
            guard let index = index else { return }
            self?.output.recentList.value.remove(at: index)

        }
        
        input.recentDeleteTapped.lazyBind { [weak self] _ in
            self?.output.recentList.value = []
            User.recentSearch = []
        }
        
        input.movieRowTapped.lazyBind { [weak self] movie in
            guard let movie = movie else { return }
            self?.output.pushToDetailVC.value = movie
        }
    
        input.loadAdditionalPage.lazyBind { [weak self] indexPaths in
            guard let listCount = self?.output.resultList.value.count else { return }
            self?.getAdditionalPage(indexPaths, listCount)
        }
        
    }
}

// MARK: - Recent Search
extension SearchViewModel {
    
    private func addToRecent(_ currentQuery: String) {
        if !User.recentSearch.contains(currentQuery) {
            User.recentSearch.insert(currentQuery, at: 0)
        }
    }
    
    
    
}

// MARK: - Search Result
extension SearchViewModel {
    
    private func getSearchResult(_ inputText: String) {
        if previousQuery != inputText {
            previousQuery = currentQuery
            currentQuery = inputText
            page = 1
            callRequest(currentQuery, page)
            addToRecent(currentQuery)
        } else {
            output.scrollResultView.value = ()
        }
    }
    
    private func getAdditionalPage(_ indexPaths: [IndexPath] , _ listCount: Int) {
        for item in indexPaths {
            if listCount - 2 == item.row && page < totalPage {
                page += 1
                callRequest(currentQuery, page)
            }
        }
    }
    
}

// MARK: - Network
extension SearchViewModel {
    
    private func callRequest(_ query: String, _ page: Int) {
        dispatchGroup.enter()
        NetworkManager.shared.callRequest(.search(query: query, page: page), Search.self) { [weak self] response, errorMessage  in
            switch response {
            case .success(let value):
                if page == 1 {
                    self?.totalPage = value.totalPages
                    self?.resultResult = value.results
                } else {
                    self?.resultResult.append(contentsOf: value.results)
                }
                self?.dispatchGroup.leave()
            case .failure(_):
                guard let errorMessage = errorMessage else { return }
                let alert = AlertSet(title: Title.warning.rawValue, message: errorMessage)
                self?.output.showAlert.value = alert
            }
        }
        dispatchGroup.notify(queue: .main) {
            if self.resultResult.isEmpty {
                self.output.showRecentView.value = ()
            } else {
                self.output.showResultView.value = ()
                self.output.reloadResultView.value = ()
                if page == 1 {
                    self.output.scrollResultView.value = ()
                }
            }
            self.output.resignResponder.value = ()
        }
    }
}
