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
    
    var movieBoxLabel = MovieBoxLabel()
    
    let overlayButton = UIButton()
    
    // MARK: - configureHierarchy
    override func configureHierarchy() {
        addSubview(backgroundView)
        
        [profileImageView, labelStackView, chevronImage, movieBoxLabel].forEach {
            backgroundView.addSubview($0)
        }

        [nicknameLabel, SignupDateLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        addSubview(overlayButton)
    }
    
    // MARK: - configureLayout
    override func configureLayout() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(130)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(14)
            make.size.equalTo(50)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalToSuperview().inset(14)
        }
        
        movieBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(14)
        }
        
        overlayButton.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView)
        }
    }
    
    // MARK: - configureView
    override func configureView() {
        backgroundView.layer.cornerRadius = 16
        backgroundView.layer.backgroundColor = UIColor.profileCardGray.cgColor

        profileImageView.image = UIImage(named: User.profileImageName)
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 25
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        
        nicknameLabel.text = User.nickname
        nicknameLabel.textColor = .white
        nicknameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        SignupDateLabel.text = User.signUpDate
        SignupDateLabel.textColor = .gray
        SignupDateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        chevronImage.image = UIImage(systemName: Resources.ImageName.chevronRight.rawValue)
        chevronImage.contentMode = .scaleAspectFit
        chevronImage.tintColor = .gray
        
        overlayButton.backgroundColor = .clear
    }
}
