//
//  SettingTableView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/31/25.
//

import UIKit

class SettingTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        backgroundColor = .clear
        isScrollEnabled = false
        
        register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
}

