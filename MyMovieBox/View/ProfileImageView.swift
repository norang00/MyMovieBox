//
//  ProfileImageView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/26/25.
//

import UIKit

final class ProfileImageView: BaseView {
    
    private let profileImageSectionView = UIView()
    let profileImageView = CircleImageView(frame: .zero)
    private let cameraImageView = UIImageView()
    
    private let selectionView = UIStackView()
    private let selectionRowView = [UIStackView(), UIStackView(), UIStackView()]
    var selectionImageViews: [UIImageView] = []
    
    override func configureHierarchy() {
        
        profileImageSectionView.addSubview(profileImageView)
        profileImageSectionView.addSubview(cameraImageView)
        addSubview(profileImageSectionView)
        
        addSubview(selectionView)
        distributeRowViews()
        makeProfileImages()
        distributeImageViews()
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
        
        
    }
    
    override func configureView() {
        super.configureView()

        // SFSymbol 사용법 참고:
        // https://jimmy-ios.tistory.com/31,
        // https://developer.apple.com/documentation/uikit/uiimage/symbolconfiguration-swift.class
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 13)
        let cameraImage = UIImage(systemName: "camera.fill", withConfiguration: symbolConfig)

        cameraImageView.image = cameraImage
        cameraImageView.contentMode = .center
        cameraImageView.tintColor = .white
        cameraImageView.layer.cornerRadius = 15
        cameraImageView.layer.backgroundColor = UIColor.accent.cgColor
        
        
        
        
        
    }
    
    func distributeRowViews() {
        selectionRowView.forEach {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            selectionView.addArrangedSubview($0)
        }
    }
    
    func makeProfileImages() {
        for index in 0..<12 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "profile_\(index)")
            imageView.contentMode = .scaleAspectFit
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = UIColor.accent.cgColor
            imageView.layer.cornerRadius = 50
            imageView.clipsToBounds = true
            selectionImageViews.append(imageView)
        }
    }
    
    func distributeImageViews() {
        for index in 0..<selectionImageViews.count {
            let rowIndex = Int(index/4)
            selectionRowView[rowIndex].addArrangedSubview(selectionImageViews[index])
        }
    }
}
