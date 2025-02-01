//
//  SearchWordSegment.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit
import SnapKit

final class SearchWordSegment: BaseView {
    
    let searchButton = UIButton()
    let xButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        addSubview(searchButton)
        addSubview(xButton)
    }
    
    override func configureLayout() {
        self.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }
        
        xButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchButton)
            make.leading.equalTo(searchButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(12)
            make.size.equalTo(12)
        }
    }
    
    override func configureView() {
        layer.cornerRadius = 15
        layer.backgroundColor = UIColor.white.cgColor
        
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        searchButton.titleLabel?.numberOfLines = 1
        searchButton.contentHorizontalAlignment = .left
        searchButton.backgroundColor = .clear
        searchButton.sizeToFit()
        
        xButton.setImage(UIImage(systemName: ImageName.cancel.rawValue), for: .normal)
        xButton.contentMode = .scaleAspectFit
        xButton.tintColor = .black
        xButton.backgroundColor = .clear
    }
}
