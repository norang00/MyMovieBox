//
//  PosterCollectionView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/30/25.
//

import UIKit

final class PosterCollectionView: UICollectionView {

    static func createCollectionViewLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 12
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.itemSize = CGSize(width: 140, height: 210)
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
        showsHorizontalScrollIndicator = false
        register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
    }
}
