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
    let trendingLabel = UILabel()
    let collectionView = TrendingCollectionView(frame: .zero, collectionViewLayout: TrendingCollectionView.createCollectionViewLayout())
    
    // MARK: - configureHierarchy
    override func configureHierarchy() {
        addSubview(profileCard)
        addSubview(trendingLabel)
        addSubview(collectionView)
    }
    
    // MARK: - configureLayout
    override func configureLayout() {
        profileCard.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(138)
        }
        
        trendingLabel.snp.makeConstraints { make in
            make.top.equalTo(profileCard.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(trendingLabel.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    // MARK: - configureView
    override func configureView() {
        super.configureView()
        
        trendingLabel.text = Resources.Title.trending.rawValue
        trendingLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
}
