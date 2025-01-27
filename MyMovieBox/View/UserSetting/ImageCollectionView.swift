//
//  ImageCollectionView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit

final class ImageCollectionView: UICollectionView {

    static func createCollectionViewLayout() -> UICollectionViewLayout {
        let sectionInset: CGFloat = 16
        let spacing: CGFloat = 8
        let width: CGFloat = UIScreen.main.bounds.width - (spacing*3) - (sectionInset*2)
        let itemWidth: CGFloat = width / 4
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
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
        isScrollEnabled = false
        register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
}
