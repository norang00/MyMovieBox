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
    let todayMovieLabel = UILabel()
    let collectionView = TodayMovieCollectionView(frame: .zero, collectionViewLayout: TodayMovieCollectionView.createCollectionViewLayout())
    
    // MARK: - configureHierarchy
    override func configureHierarchy() {
        addSubview(profileCard)
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
        
        todayMovieLabel.snp.makeConstraints { make in
            make.top.equalTo(profileCard.snp.bottom).offset(24)
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
        
        todayMovieLabel.text = Title.todayMovie.rawValue
        todayMovieLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
}
