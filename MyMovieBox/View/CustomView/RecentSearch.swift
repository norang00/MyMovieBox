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
        backgroundView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
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
            make.height.equalTo(30)
        }
        
        recentSearchStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    // MARK: - configureView
    override func configureView() {
        recentSearchLabel.text = Resources.Title.recentSearch.rawValue
        recentSearchLabel.font = .systemFont(ofSize: 16, weight: .bold)

        recentSearchDeleteButton.setTitle(Resources.Title.deleteAll.rawValue, for: .normal)
        recentSearchDeleteButton.setTitleColor(.accent, for: .normal)
        recentSearchDeleteButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        recentSearchEmptyLabel.text = Resources.Title.noRecentSearch.rawValue
        recentSearchEmptyLabel.textColor = .gray
        recentSearchEmptyLabel.font = .systemFont(ofSize: 14, weight: .medium)

        recentSearchScrollView.isScrollEnabled = true
        recentSearchScrollView.showsHorizontalScrollIndicator = false
        recentSearchScrollView.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        recentSearchStackView.axis = .horizontal
        recentSearchStackView.spacing = 8
    }
}
