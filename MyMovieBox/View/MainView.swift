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

    let latestSearchView = UIView()
    let latestSearchLabel = UILabel()
    let latestSearchScrollView = UIScrollView()
    let latestSearchStackView = UIStackView()
    
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
        addSubview(latestSearchView)
        addSubview(todayMovieView)
        
        addSubview(tempButton)
    }

    override func configureLayout() {
        profileCard.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(136)
        }
        
        latestSearchView.snp.makeConstraints { make in
            make.top.equalTo(profileCard.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(70)
        }
        
        todayMovieView.snp.makeConstraints { make in
            make.top.equalTo(latestSearchView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
            
        }

        tempButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        latestSearchView.backgroundColor = .green
        todayMovieView.backgroundColor = .blue
    }
    
}
