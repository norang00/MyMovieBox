//
//  ProfileCard.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit
import SnapKit

final class ProfileCard: BaseView {
    
    private let backgroundView = UIView()
    let profileImageView = CircleImage(frame: .zero)
    private let labelStackView = UIStackView()
    var nicknameLabel = UILabel()
    var SignupDateLabel = UILabel()
    private var chevronImage = UIImageView()
    var likeLabel = UILabel()
    let overlayButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(backgroundView)
        
        [profileImageView, labelStackView, chevronImage, likeLabel].forEach {
            backgroundView.addSubview($0)
        }

        [nicknameLabel, SignupDateLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        addSubview(overlayButton)
    }
    
    override func configureLayout() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(120)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.size.equalTo(50)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalToSuperview().inset(16)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
        }
        
        overlayButton.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView)
        }
    }
    
    override func configureView() {
        backgroundView.layer.cornerRadius = 16
        backgroundView.layer.backgroundColor = UIColor.gray3.cgColor

        profileImageView.image = UIImage(named: User.profileImageName)
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 25
        
        labelStackView.axis = .vertical
        
        nicknameLabel.text = User.nickname
        nicknameLabel.textColor = .white
        nicknameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        SignupDateLabel.text = User.signUpDate
        SignupDateLabel.textColor = .gray1
        SignupDateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        chevronImage.image = UIImage(systemName: "chevron.right")
        chevronImage.contentMode = .scaleAspectFit
        chevronImage.tintColor = .gray1
        
        likeLabel.text = "\(User.likedMovies.count)개의 무비박스 보관중"
        likeLabel.textAlignment = .center
        likeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        likeLabel.layer.cornerRadius = 8
        likeLabel.layer.backgroundColor = UIColor.accent.cgColor

        overlayButton.backgroundColor = .clear
    }
}
