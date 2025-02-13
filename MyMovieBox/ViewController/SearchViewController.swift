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

        configureNavigation(Resources.Title.searchNav.rawValue)
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
        
        searchViewModel.output.recentList.bind { [weak self] recentList in
            self?.configureRecentView(recentList)
        }
        
        searchViewModel.output.searchText.lazyBind { [weak self] text in
            guard let text = text else { return }
            self?.searchView.searchBar.text = text
        }
        
        searchViewModel.output.becomeResponder.bind { [weak self] _ in
            self?.searchView.searchBar.becomeFirstResponder()
        }
        
        searchViewModel.output.resultList.lazyBind { [weak self] resultList in
            self?.searchView.resultTableView.reloadData()
        }
        
        searchViewModel.output.showResultView.lazyBind { [weak self] value in
            self?.searchView.recentSearch.isHidden = value ? true : false
            self?.searchView.resultTableView.isHidden = value ? false : true
        }
        
        searchViewModel.output.scrollResultView.lazyBind { [weak self] _ in
            self?.searchView.resultTableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                                         at: .top, animated: false)
        }
        
        searchViewModel.output.resignResponder.lazyBind { [weak self] _ in
            self?.searchView.endEditing(true)
        }
        
        searchViewModel.output.showAlert.lazyBind { [weak self] alertSet in
            guard let alertSet = alertSet else { return }
            self?.showAlert(title: alertSet.title, message: alertSet.message)
        }
        
        searchViewModel.output.pushToDetailVC.lazyBind { [weak self] movie in
            guard let movie = movie else { return }
            self?.pushToDetailView(movie)
        }
        
        searchViewModel.output.toggleLike.lazyBind { [weak self] index in
            guard let index = index else { return }
            let cell = self?.searchView.resultTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SearchTableViewCell
            cell?.likeButton.isSelected.toggle()
        }
    }
}

// MARK: - SearchBar
extension SearchViewController: UISearchBarDelegate {
    
    private func configureSearchBar() {
        searchView.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchViewModel.input.searchTextDidChange.value = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let inputText = searchBar.text else { return }
        searchViewModel.input.searchButtonTapped.value = inputText
    }
}

// MARK: - Recent Search
extension SearchViewController {
    
    func configureRecentView(_ recentList: [String]) {
        searchView.recentSearch.recentSearchStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        searchView.recentSearch.recentSearchDeleteButton.addTarget(self, action: #selector(recentDeleteAllTapped), for: .touchUpInside)
        
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
                button.searchButton.addTarget(self, action: #selector(recentKeywordTapped), for: .touchUpInside)
                button.xButton.tag = index
                button.xButton.addTarget(self, action: #selector(recentKeywordXTapped), for: .touchUpInside)
                searchView.recentSearch.recentSearchStackView.addArrangedSubview(button)
            }
            searchView.layoutSubviews()
        }
    }
    
    @objc
    func recentKeywordTapped(_ sender: UIButton) {
        searchViewModel.input.recentKeywordTapped.value = sender.titleLabel?.text
    }
    
    @objc
    func recentKeywordXTapped(_ sender: UIButton) {
        searchViewModel.input.recentKeywordXTapped.value = sender.tag
    }
    
    @objc
    func recentDeleteAllTapped() {
        searchViewModel.input.recentDeleteAllTapped.value = ()
    }
}

// MARK: - TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    private func configureTableView() {
        searchView.resultTableView.delegate = self
        searchView.resultTableView.dataSource = self
        searchView.resultTableView.prefetchDataSource = self
        searchView.resultTableView.keyboardDismissMode = .onDrag
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let resultList = searchViewModel.output.resultList.value
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.resultTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
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
        searchView.resultTableView.deselectRow(at: indexPath, animated: true)
        searchViewModel.input.movieRowTapped.value = resultList[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        searchViewModel.input.loadAdditionalPage.value = indexPaths
    }
    
    private func pushToDetailView(_ movie: Movie) {
        let detailVC = DetailViewController()
        detailVC.detailViewModel.input.movie.value = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Like
extension SearchViewController {
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        searchViewModel.input.likeButtonTapped.value = sender.tag
    }
    
    // [TODO] 좋아요 영화랑 플래그 별도 모델링 해서 뷰모델에서 처리해보기
    private func reloadLike() {
        let resultList = searchViewModel.output.resultList.value
        let userLikedMovies = User.likedMovies
        for index in 0..<resultList.count {
            let movie = resultList[index]
            let cell = searchView.resultTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SearchTableViewCell
            cell?.likeButton.isSelected = userLikedMovies.contains(movie.id)
        }
    }
}
