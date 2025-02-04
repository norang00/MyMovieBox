//
//  MainView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit
import SnapKit

final class MainView: BaseView {

    let profileCard = ProfileCard()

    let recentSearchLabel = UILabel()
    let recentSearchDeleteButton = UIButton()
    let recentSearchEmptyView = UIView()
    let recentSearchEmptyLabel = UILabel()
    let recentSearchScrollView = UIScrollView()
    let recentSearchStackView = UIStackView()
    
    let todayMovieLabel = UILabel()
    let collectionView = TodayMovieCollectionView(frame: .zero, collectionViewLayout: TodayMovieCollectionView.createCollectionViewLayout())
    
    // MARK: - configureHierarchy
    override func configureHierarchy() {
        addSubview(profileCard)
        
        addSubview(recentSearchLabel)
        addSubview(recentSearchDeleteButton)
        addSubview(recentSearchEmptyView)
        recentSearchEmptyView.addSubview(recentSearchEmptyLabel)
        
        addSubview(recentSearchScrollView)
        recentSearchScrollView.addSubview(recentSearchStackView)
        
        addSubview(todayMovieLabel)
        addSubview(collectionView)
    }
    
    // MARK: - configureLayout
    override func configureLayout() {
        profileCard.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(138)
        }
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(profileCard.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        recentSearchDeleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        recentSearchEmptyView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
                
        recentSearchEmptyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        recentSearchScrollView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        recentSearchStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(recentSearchScrollView)
            make.height.equalTo(30)
        }

        todayMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(recentSearchEmptyView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(todayMovieLabel.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    // MARK: - configureView
    override func configureView() {
        super.configureView()
        
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
        
        todayMovieLabel.text = Title.todayMovie.rawValue
        todayMovieLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
}
