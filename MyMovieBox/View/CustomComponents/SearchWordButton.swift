//
//  SearchWordSegment.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit
import SnapKit

final class SearchWordButton: UIView {
    
    let searchButton = UIButton()
    let xButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSearchButton()
        configureXButton()
        
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        layer.cornerRadius = 15
        layer.backgroundColor = UIColor.white.cgColor
        isUserInteractionEnabled = true
        
        addSubview(searchButton)
        addSubview(xButton)
    }
    
    private func configureSearchButton() {
        searchButton.setTitle("검색어", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        searchButton.contentHorizontalAlignment = .left
        searchButton.backgroundColor = .clear
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func configureXButton() {
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.contentMode = .scaleAspectFit
        xButton.tintColor = .black
        xButton.backgroundColor = .clear
        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
    }
    
    private func configureLayout() {
        searchButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }

        xButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(15)
        }
    }
    
    @objc private func searchButtonTapped() {
        print("검색 버튼 클릭됨")
    }
    
    @objc private func xButtonTapped() {
        print("X 버튼 클릭됨")
    }
}

//
//final class SearchWordButton: UIButton {
//    
//    let xButton = UIButton()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.frame = CGRect(x: 5.0, y: 5.0, width: 60.0, height: 15.0)
//        xButton.frame = CGRect(x: 10, y: 2, width: 20, height: 20)
//        addSubview(xButton)
//        configureSearchButton()
//        configureXButton()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configureSearchButton() {
//        layer.cornerRadius = 15
//        layer.backgroundColor = UIColor.white.cgColor
//        setTitle("검색어", for: .normal)
//        setTitleColor(.black, for: .normal)
//        titleLabel?.textAlignment = .left
//        titleLabel?.font = .boldSystemFont(ofSize: 16)
//        
//    }
//    
//    func configureXButton() {
//        xButton.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().inset(8)
//        }
//        
//        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
//        xButton.contentMode = .scaleAspectFit
//        xButton.tintColor = .black
//        xButton.backgroundColor = .clear
//    }
//}
