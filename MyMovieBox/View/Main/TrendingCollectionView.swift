//
//  TrendingCollectionView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit

final class TrendingCollectionView: UICollectionView {

    static func createCollectionViewLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 12
        let spacing: CGFloat = 20
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        layout.itemSize = CGSize(width: 220, height: 380)
        return layout
    }
        
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
    }
}
