//
//  SearchViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    
    var query: String? = "어벤"
    var page: Int = 1
    var totalPage: Int?
    var searchResults: [Movie] = []
    let dispatchGroup = DispatchGroup()
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation("영화 검색")

        getSearchResult()
        configureTableView()
    }
}

// MARK: - TableView, pagination
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchView.tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let movie = searchResults[indexPath.row]
        cell.configureData(movie, false)
        
        return cell
    }
    
}

// MARK: - Network
extension SearchViewController {
    
    private func getSearchResult() {
        guard let query = query else { return }
        
        dispatchGroup.enter()
        NetworkManager.shared.callRequest(.search(query: query, page: page), Search.self) { Result in
            self.searchResults = Result.results
            self.totalPage = Result.totalPages
            self.dispatchGroup.leave()
        } failureHandler: { errorMessage in
            print(#function, TMDBRequest.search(query: query, page: self.page))
            self.showAlert(title: "이런! 문제가 발생했어요", message: errorMessage)
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.searchView.tableView.reloadData()
        }
    }
}
