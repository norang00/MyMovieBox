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
        let showRecentView: Observable<Bool?> = Observable(nil) // 이게 맞나...?
        let showResultView: Observable<Bool?> = Observable(nil) // 어디까지 지정해야..?
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
        input.viewLoaded.bind { [weak self] _ in // [고민] 아직 VC 생성 전에 트리거를 걸어줘봐야...?
            print(#file, #function)
            self?.output.becomeResponder.value = ()
            self?.output.recentList.value = User.recentSearch
        }
        
        input.searchButtonTapped.lazyBind { [weak self] inputText in
            guard let inputText = inputText else { return }
            print(#file, #function, inputText)
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
        print(#file, #function, currentQuery)

        if !User.recentSearch.contains(currentQuery) {
            User.recentSearch.insert(currentQuery, at: 0)
        }
    }
    
    
    
}

// MARK: - Search Result
extension SearchViewModel {
    
    private func getSearchResult(_ inputText: String) {
        print(#file, #function, inputText)

        if previousQuery != inputText {
            previousQuery = currentQuery
            currentQuery = inputText
            page = 1

            print(#file, #function, "previousQuery != inputText", inputText)

            callRequest(currentQuery, page)
            addToRecent(currentQuery)
        } else {
            
            print(#file, #function, inputText)

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
        
        print(#file, #function, query)

        dispatchGroup.enter()
        NetworkManager.shared.callRequest(.search(query: query, page: page), Search.self) { [weak self] response  in
            switch response {
            case .success(let value):
                if page == 1 {
                    self?.totalPage = value.totalPages
                    self?.resultResult = value.results
                } else {
                    self?.resultResult.append(contentsOf: value.results)
                }
                self?.dispatchGroup.leave()
            case .failure(let error):
                let alert = AlertSet(title: Resources.Alert.Title.warning.rawValue,
                                     message: error.rawValue)
                self?.output.showAlert.value = alert
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if self.resultResult.isEmpty {
                self.output.showResultView.value = false
                self.output.showAlert.value =
                AlertSet(title: Resources.Alert.Title.noResult.rawValue,
                         message: Resources.Alert.Message.noResult.rawValue)
            } else {
                self.output.showResultView.value = true
                self.output.reloadResultView.value = ()
//                if page == 1 {
//                    self.output.scrollResultView.value = ()
//                }
            }
            self.output.resignResponder.value = ()
        }
    }
}
