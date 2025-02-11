//
//  RecentSearch.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 2/11/25.
//

import UIKit
import SnapKit

final class RecentSearch: BaseView {

    private let backgroundView = UIView()
    let recentSearchLabel = UILabel()
    let recentSearchDeleteButton = UIButton()
    let recentSearchEmptyView = UIView()
    let recentSearchEmptyLabel = UILabel()
    let recentSearchScrollView = UIScrollView()
    let recentSearchStackView = UIStackView()
    
    // MARK: - configureHierarchy
    override func configureHierarchy() {
        addSubview(backgroundView)
        
        [recentSearchLabel, recentSearchDeleteButton,
         recentSearchEmptyView, recentSearchScrollView].forEach {
            backgroundView.addSubview($0)
        }
        
        recentSearchEmptyView.addSubview(recentSearchEmptyLabel)
        recentSearchScrollView.addSubview(recentSearchStackView)
    }
    
    // MARK: - configureLayout
    override func configureLayout() {
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().inset(12)
        }
        
        recentSearchDeleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel)
            make.trailing.equalToSuperview().inset(12)
        }
        
        recentSearchEmptyView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
                
        recentSearchEmptyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        recentSearchScrollView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        recentSearchStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(recentSearchScrollView)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - configureView
    override func configureView() {
        backgroundView.backgroundColor = .clear

        recentSearchLabel.text = Title.recentSearch.rawValue
        recentSearchLabel.font = .systemFont(ofSize: 20, weight: .bold)

        recentSearchDeleteButton.setTitle(Title.deleteAll.rawValue, for: .normal)
        recentSearchDeleteButton.setTitleColor(.accent, for: .normal)
        recentSearchDeleteButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        recentSearchEmptyLabel.text = Title.noRecentSearch.rawValue
        recentSearchEmptyLabel.textColor = .gray
        recentSearchEmptyLabel.font = .systemFont(ofSize: 14, weight: .medium)

        recentSearchScrollView.isScrollEnabled = true
        recentSearchScrollView.showsHorizontalScrollIndicator = false
        recentSearchScrollView.contentInset = UIEdgeInsets(top: 7, left: 12, bottom: 7, right: 12)
        
        recentSearchStackView.axis = .horizontal
        recentSearchStackView.spacing = 8
    }
}
