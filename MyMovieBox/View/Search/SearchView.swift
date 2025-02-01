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
    let tableView = SearchTableView()
    let emptyLabel = UILabel()

    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(emptyLabel)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        searchBar.placeholder = Title.searchPlaceholder.rawValue
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .accent

        emptyLabel.textColor = .gray1
        emptyLabel.font = .systemFont(ofSize: 16, weight: .medium)
        emptyLabel.isHidden = true
    }
}
