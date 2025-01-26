//
//  ProfileImageView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/26/25.
//

import UIKit

final class ProfileImageView: BaseView {
    
    let label = {
        let label = UILabel()
        label.text = "프로필 이미지 뷰"
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(label)
    }

    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .black
    }
    
}
