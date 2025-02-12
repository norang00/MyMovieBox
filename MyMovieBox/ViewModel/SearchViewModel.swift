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
    
    private var totalPage = 0
    private var page = 1
    private var query: String?
    private var resultList: [Movie] = []
    private var dispatchGroup = DispatchGroup()

    struct Input {
        let loadRecentList: Observable<Void?> = Observable(nil)
        let recentKeywordTapped: Observable<String?> = Observable(nil)
        let recentKeywordXTapped: Observable<Int?> = Observable(nil)
        let recentDeleteAllTapped: Observable<Void?> = Observable(nil)

        let searchTextDidChange: Observable<String?> = Observable(nil)
        let searchButtonTapped: Observable<String?> = Observable(nil)
        let movieRowTapped: Observable<Movie?> = Observable(nil)
        let loadAdditionalPage: Observable<[IndexPath]> = Observable([])
        
        let likeButtonTapped: Observable<Int?> = Observable(nil)
    }
    
    struct Output {
        let recentList: Observable<[String]> = Observable([])
        let reloadRecentView: Observable<Void?> = Observable(nil)

        let searchText: Observable<String?> = Observable(nil)
        let resultList: Observable<[Movie]> = Observable([])
        let reloadResultView: Observable<Void?> = Observable(nil)
        let showResultView: Observable<Bool> = Observable(false)
        let scrollResultView: Observable<Void?> = Observable(nil)

        let becomeResponder: Observable<Void?> = Observable(nil)
        let resignResponder: Observable<Void?> = Observable(nil)
        let pushToDetailVC: Observable<Movie?> = Observable(nil)
        let toggleLike: Observable<Int?> = Observable(nil)
        let showAlert: Observable<AlertSet?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    // MARK: - transform
    func transform() {
        input.loadRecentList.bind { [weak self] _ in
            self?.output.recentList.value = User.recentSearch
        }

        input.recentKeywordTapped.lazyBind { [weak self] keyword in
            guard let keyword = keyword else { return }
            self?.output.searchText.value = keyword
            self?.getSearchResult(keyword)
        }
        
        input.recentKeywordXTapped.lazyBind { [weak self] index in
            guard let index = index else { return }
            User.recentSearch.remove(at: index)
            self?.output.recentList.value = User.recentSearch
        }
        
        input.recentDeleteAllTapped.lazyBind { [weak self] _ in
            User.recentSearch.removeAll()
            self?.output.recentList.value = User.recentSearch
        }
        
        input.searchTextDidChange.lazyBind { [weak self] inputText in
            guard let inputText = inputText else { return }
            if inputText.isEmpty {
                self?.output.showResultView.value = false
            }
        }
        
        input.searchButtonTapped.lazyBind { [weak self] inputText in
            guard let inputText = inputText else { return }
            self?.validateKeyword(inputText)
        }
        
        input.movieRowTapped.lazyBind { [weak self] movie in
            guard let movie = movie else { return }
            self?.output.pushToDetailVC.value = movie
        }
    
        input.loadAdditionalPage.lazyBind { [weak self] indexPaths in
            guard let listCount = self?.output.resultList.value.count else { return }
            self?.getAdditionalPage(indexPaths, listCount)
        }
        
        input.likeButtonTapped.lazyBind { [weak self] index in
            guard let index = index else { return }
            self?.output.toggleLike.value = index
            guard let movie = self?.output.resultList.value[index] else { return }
            self?.toggleLike(movie.id)
        }
    }
}

// MARK: - Recent Search
extension SearchViewModel {
    
    private func addToRecent(_ currentQuery: String) {
        if !User.recentSearch.contains(currentQuery) {
            User.recentSearch.insert(currentQuery, at: 0)
        }
        output.recentList.value = User.recentSearch
    }
}

// MARK: - Search Result
extension SearchViewModel {
        
    private func validateKeyword(_ inputText: String) {
        if inputText.replacingOccurrences(of: " ", with: "").count == 0 {
            self.output.showAlert.value =
            AlertSet(title: Resources.Alert.Title.emptyInput.rawValue,
                     message: Resources.Alert.Message.emptyInput.rawValue)
            self.output.searchText.value = ""
        } else if inputText.count > 20 {
            self.output.showAlert.value =
            AlertSet(title: Resources.Alert.Title.tooLongKeyword.rawValue,
                     message: Resources.Alert.Message.tooLongKeyword.rawValue)
            self.output.searchText.value = ""
        } else {
            getSearchResult(inputText)
        }
    }
    
    private func getSearchResult(_ inputText: String) {
        if inputText == query {
            if output.resultList.value.isEmpty {
                output.showAlert.value = AlertSet(title: Resources.Alert.Title.noResult.rawValue,
                                                  message: Resources.Alert.Message.noResult.rawValue)
                self.output.searchText.value = ""
            } else {
                output.scrollResultView.value = ()
            }
        } else {
            page = 1
            query = inputText
            callRequest(query!, page)
            addToRecent(query!)
        }
    }
    
    private func getAdditionalPage(_ indexPaths: [IndexPath] , _ listCount: Int) {
        guard let query = query else { return }
        for item in indexPaths {
            if listCount - 2 == item.row && page < totalPage {
                page += 1
                callRequest(query, page)
            }
        }
    }
}

// MARK: - Like
// [TODO] 얘도 그냥 모아서 하나로 빼도 되겠다.
extension SearchViewModel {
    private func toggleLike(_ movieID: Int) {
        User.toggleLike(movieID)
    }
}

// MARK: - Network
extension SearchViewModel {
    
    private func callRequest(_ query: String, _ page: Int) {
        dispatchGroup.enter()
        NetworkManager.shared.callRequest(.search(query: query, page: page), Search.self) { [weak self] response  in
            switch response {
            case .success(let value):
                if page == 1 {
                    self?.totalPage = value.totalPages
                    self?.resultList = value.results
                } else {
                    self?.resultList.append(contentsOf: value.results)
                }
                self?.dispatchGroup.leave()
            case .failure(let error):
                let alert = AlertSet(title: Resources.Alert.Title.warning.rawValue,
                                     message: error.rawValue)
                self?.output.showAlert.value = alert
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if self.resultList.isEmpty {
                self.output.showResultView.value = false
                self.output.showAlert.value =
                AlertSet(title: Resources.Alert.Title.noResult.rawValue,
                         message: Resources.Alert.Message.noResult.rawValue)
            } else {
                self.output.resultList.value = self.resultList
                self.output.showResultView.value = true
                print(#function, "result")

                if page == 1 {
                    self.output.scrollResultView.value = ()
                }
            }
            self.output.resignResponder.value = ()
        }
    }
}
