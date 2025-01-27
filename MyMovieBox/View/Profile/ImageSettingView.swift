//
//  ImageSettingView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/26/25.
//

import UIKit

final class ImageSettingView: BaseView {
    
    private let profileImageSectionView = UIView()
    let profileImageView = CircleImage(frame: .zero)
    private let cameraImageView = CameraIcon(frame: .zero)
    
    let collectionView = ImageCollectionView(frame: .zero, collectionViewLayout: ImageCollectionView.createCollectionViewLayout())
    
    override func configureHierarchy() {
        profileImageSectionView.addSubview(profileImageView)
        profileImageSectionView.addSubview(cameraImageView)
        addSubview(profileImageSectionView)
        addSubview(collectionView)
    }

    override func configureLayout() {
        profileImageSectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.size.equalTo(100)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImageSectionView.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
    }
}
