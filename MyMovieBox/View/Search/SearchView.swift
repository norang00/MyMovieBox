//
//  SearchView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit
import SnapKit

final class SearchView: BaseView {

    let searchBar = UISearchBar()
    let recentSearch = RecentSearch()
    let tableView = SearchTableView()

    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(recentSearch)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(8)
        }

        recentSearch.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        searchBar.placeholder = Title.searchPlaceholder.rawValue
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .accent
        
        tableView.isHidden = true
    }
}
