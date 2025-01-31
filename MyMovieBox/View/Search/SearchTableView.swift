//
//  SearchTableView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit

final class SearchTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        
        register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
}

