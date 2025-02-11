//
//  SearchViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    var recentSearchList: [String] = [] {
        didSet {
            User.recentSearch = recentSearchList
        }
    }

    private var previousQuery: String = ""
    var currentQuery: String = ""
    private var page: Int = 1
    private var totalPage: Int?
    private var searchResults: [Movie] = []
    private let dispatchGroup = DispatchGroup()
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation(Title.searchNav.rawValue)
        configureSearchBar()
        configureTableView()
        configureRecentSearchWords()

        if currentQuery.isEmpty {
            searchView.searchBar.becomeFirstResponder()
        } else {
//            callRequest(currentQuery, page)
            searchView.searchBar.text = currentQuery
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadLike()
    }
}

// MARK: - SearchBar
extension SearchViewController: UISearchBarDelegate {
    
    private func configureSearchBar() {
        searchView.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let inputText = searchBar.text else { return }
        if previousQuery != inputText {
            previousQuery = currentQuery
            currentQuery = inputText
            page = 1
//            callRequest(currentQuery, page)
            
            if !User.recentSearch.contains(currentQuery) {
                User.recentSearch.insert(currentQuery, at: 0)
            }
            
        } else {
            searchView.tableView.reloadData()
            searchView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

// MARK: - TableView, Pagination
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    private func configureTableView() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.prefetchDataSource = self
        searchView.tableView.keyboardDismissMode = .onDrag
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
    
        if !self.searchResults.isEmpty {
            let movie = searchResults[indexPath.row]
            cell.configureData(movie, User.checkLike(movie.id))
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.movie = searchResults[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
        searchView.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let totalPage = totalPage else { return }
        
        for item in indexPaths {
            if searchResults.count - 2 == item.row && page < totalPage {
                page += 1
//                callRequest(currentQuery, page)
            }
        }
    }

    // MARK: 좋아요 기능
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        let movie = searchResults[sender.tag]
        User.toggleLike(movie)
        sender.isSelected.toggle()
    }
    
    private func reloadLike() {
        let userLikedMovies = User.likedMovies
        for index in 0..<searchResults.count {
            let movie = searchResults[index]
            let cell = searchView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SearchTableViewCell
            cell?.likeButton.isSelected = userLikedMovies.contains(movie.id)
        }
    }
}
// MARK: - Recent Search
extension SearchViewController {
    
    func configureRecentSearchWords() {
        recentSearchList = User.recentSearch
        searchView.recentSearch.recentSearchStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        searchView.recentSearch.recentSearchDeleteButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
        
        if recentSearchList.isEmpty {
            searchView.recentSearch.recentSearchDeleteButton.isHidden = true
            searchView.recentSearch.recentSearchEmptyView.isHidden = false

        } else {
            searchView.recentSearch.recentSearchDeleteButton.isHidden = false
            searchView.recentSearch.recentSearchEmptyView.isHidden = true

            for index in 0..<recentSearchList.count {
                let button = SearchWordSegment(frame: .zero)
                button.searchButton.setTitle(recentSearchList[index], for: .normal)
                button.searchButton.tag = index
                button.searchButton.addTarget(self, action: #selector(getSearchResult), for: .touchUpInside)
                button.xButton.tag = index
                button.xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
                searchView.recentSearch.recentSearchStackView.addArrangedSubview(button)
            }
        }
    }
    
    @objc
    func xButtonTapped(_ sender: UIButton) {
        recentSearchList.remove(at: sender.tag)
        configureRecentSearchWords()
    }
    
    @objc
    func deleteAllButtonTapped() {
        recentSearchList = []
        configureRecentSearchWords()
    }
    
    @objc
    func getSearchResult(_ sender: UIButton) {
        searchView.recentSearch.isHidden = false
//        callRequest(recentSearchList[sender.tag], 1)
    }
}

// MARK: - Network
extension SearchViewController {
    
//    private func callRequest(_ query: String, _ page: Int) {
//        dispatchGroup.enter()
//        NetworkManager.shared.callRequest(.search(query: query, page: page), Search.self) { Result in
//            if page == 1 {
//                self.totalPage = Result.totalPages
//                self.searchResults = Result.results
//            } else {
//                self.searchResults.append(contentsOf: Result.results)
//            }
//            self.dispatchGroup.leave()
//        } failureHandler: { errorMessage in
//            self.showAlert(title: Title.warning.rawValue, message: errorMessage)
//            self.dispatchGroup.leave()
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            if self.searchResults.isEmpty {
//                self.searchView.tableView.isHidden = true
//            } else {
//                self.searchView.tableView.isHidden = false
//                self.searchView.tableView.reloadData()
//                
//                if page == 1 {
//                    self.searchView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//                }
//            }
//            self.searchView.endEditing(true)
//        }
//    }
}
