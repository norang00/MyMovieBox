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
    let resultTableView = SearchResultTableView()

    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(recentSearch)
        addSubview(resultTableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(8)
        }

        recentSearch.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(100)
        }

        resultTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        searchBar.placeholder = Resources.Title.searchPlaceholder.rawValue
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .accent
        
        resultTableView.isHidden = true
    }
}
