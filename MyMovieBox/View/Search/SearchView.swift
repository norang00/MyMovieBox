//
//  SearchView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit

final class SearchView: BaseView {

    let searchBar = UISearchBar()
    let tableView = SearchTableView()

    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        // MARK: Search Bar
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        // MARK: TableView
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "키워드 검색"
        searchBar.searchBarStyle = .minimal
    }
}
