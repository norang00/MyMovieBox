//
//  SearchWordSegment.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit

final class SearchWordSegment: BaseView {
    
    let searchButton = UIButton()
    let xButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(searchButton)
        addSubview(xButton)
    }
    
    override func configureLayout() {
        snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
        }
        searchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
            make.height.equalTo(40)
        }
        
        xButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(searchButton.snp.trailing).offset(8)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        layer.cornerRadius = 16
        layer.backgroundColor = UIColor.white.cgColor
        
        searchButton.setTitle("검색어", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        searchButton.backgroundColor = .clear

        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .white
        xButton.backgroundColor = .clear
    }
}
