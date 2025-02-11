//
//  SearchViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    let searchViewModel = SearchViewModel()
    
    // MARK: - ViewLifeCycle
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation(Title.searchNav.rawValue)
        configureRecentView(searchViewModel.output.recentList.value)
        configureSearchBar()
        configureTableView()
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadLike()
    }
    
    // MARK: - bindData
    private func bindData() {
        
        searchViewModel.output.recentList.lazyBind { [weak self] recentList in
            self?.configureRecentView(recentList)
        }
        
        searchViewModel.output.reloadResultView.lazyBind { [weak self] _ in
            self?.searchView.tableView.reloadData()
        }
        
        searchViewModel.output.scrollResultView.lazyBind { [weak self] _ in
            self?.searchView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
        searchViewModel.output.becomeResponder.lazyBind { [weak self] _ in
            self?.searchView.searchBar.becomeFirstResponder()
        }
        
        searchViewModel.output.resignResponder.lazyBind { [weak self] _ in
            self?.searchView.endEditing(true)
        }

    }
}

// MARK: - SearchBar
extension SearchViewController: UISearchBarDelegate {
    
    private func configureSearchBar() {
        searchView.searchBar.delegate = self
    }
    
    func searchButtonTapped(_ searchBar: UISearchBar) {
        guard let inputText = searchBar.text else { return }
        searchViewModel.input.searchButtonTapped.value = inputText
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
        let resultList = searchViewModel.output.resultList.value
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let resultList = searchViewModel.output.resultList.value
        if !resultList.isEmpty {
            let movie = resultList[indexPath.row]
            cell.configureData(movie, User.checkLike(movie.id))
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resultList = searchViewModel.output.resultList.value
        searchView.tableView.deselectRow(at: indexPath, animated: true)
        searchViewModel.input.movieRowTapped.value = resultList[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        searchViewModel.input.loadAdditionalPage.value = indexPaths
    }
    
    private func pushToDetailView(_ movie: Movie) {
        let detailVC = DetailViewController()
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Recent Search
extension SearchViewController {
    
    // [고민] ...심각한디
    func configureRecentView(_ recentList: [String]) {
        searchView.recentSearch.recentSearchStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        searchView.recentSearch.recentSearchDeleteButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
        
        if recentList.isEmpty {
            searchView.recentSearch.recentSearchDeleteButton.isHidden = true
            searchView.recentSearch.recentSearchEmptyView.isHidden = false

        } else {
            searchView.recentSearch.recentSearchDeleteButton.isHidden = false
            searchView.recentSearch.recentSearchEmptyView.isHidden = true

            for index in 0..<recentList.count {
                let button = SearchWordSegment(frame: .zero)
                button.searchButton.setTitle(recentList[index], for: .normal)
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
        searchViewModel.input.recentXButtonTapped.value = sender.tag
        configureRecentView(searchViewModel.output.recentList.value)
    }
    
    @objc
    func deleteAllButtonTapped() {
        searchViewModel.input.recentDeleteTapped.value = ()
        configureRecentView(searchViewModel.output.recentList.value)
    }
    
    @objc
    func getSearchResult(_ sender: UIButton) {
        searchView.recentSearch.isHidden = false
//        callRequest(recentSearchList[sender.tag], 1)
    }
}
// MARK: - Like
extension SearchViewController {
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        let movie = searchViewModel.output.resultList.value[sender.tag]
        User.toggleLike(movie.id)
        sender.isSelected.toggle()
    }
    
    private func reloadLike() {
        let resultList = searchViewModel.output.resultList.value
        let userLikedMovies = User.likedMovies
        for index in 0..<resultList.count {
            let movie = resultList[index]
            let cell = searchView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SearchTableViewCell
            cell?.likeButton.isSelected = userLikedMovies.contains(movie.id)
        }
    }
}
