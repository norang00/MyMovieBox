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
    
    let todayMovieView = UIView()
    let todayMovieLabel = UILabel()
//    let todayMovieCollectionView = UICollectionView()
    
    let tempButton = {
        let button = UIButton()
        button.setTitle("user 지우기", for: .normal)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(profileCard)
        
        addSubview(recentSearchLabel)
        addSubview(recentSearchDeleteButton)
        addSubview(recentSearchEmptyView)
        recentSearchEmptyView.addSubview(recentSearchEmptyLabel)
        
        addSubview(recentSearchScrollView)
        recentSearchScrollView.addSubview(recentSearchStackView)
        
        addSubview(todayMovieLabel)
        addSubview(todayMovieView)
        
        addSubview(tempButton)
    }

    override func configureLayout() {
        // 프로필 카드
        profileCard.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(136)
        }
        
        //최근 검색어 영역
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(profileCard.snp.bottom).offset(12)
            make.leading.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        recentSearchDeleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        recentSearchEmptyView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
                
        recentSearchEmptyLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        recentSearchScrollView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(44)
        }
        
        recentSearchStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.width.equalToSuperview()
        }

        // 오늘의 영화 영역
        todayMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(recentSearchEmptyView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        todayMovieView.snp.makeConstraints { make in
            make.top.equalTo(todayMovieLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
            make.bottom.equalToSuperview()
        }

        tempButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        recentSearchLabel.text = "최근검색어"
        recentSearchLabel.font = .systemFont(ofSize: 20, weight: .bold)

        recentSearchDeleteButton.setTitle("전체 삭제", for: .normal)
        recentSearchDeleteButton.setTitleColor(.accent, for: .normal)
        
        recentSearchEmptyLabel.text = "최근 검색어 내역이 없습니다."
        recentSearchEmptyLabel.textColor = .titleGray
        recentSearchEmptyLabel.font = .systemFont(ofSize: 16, weight: .medium)

        recentSearchScrollView.isScrollEnabled = true
        recentSearchScrollView.showsHorizontalScrollIndicator = false
        recentSearchScrollView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        recentSearchStackView.axis = .horizontal
        recentSearchStackView.spacing = 8
        recentSearchStackView.distribution = .equalSpacing
        
        todayMovieLabel.text = "오늘의 영화"
        todayMovieLabel.font = .systemFont(ofSize: 20, weight: .bold)
        todayMovieView.backgroundColor = .blue
    }
    
}
