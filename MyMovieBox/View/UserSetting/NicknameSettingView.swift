//
//  NicknameSettingView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/25/25.
//

import UIKit

final class NicknameSettingView: BaseView {

    private let profileImageSectionView = UIView()
    let profileImageView = CircleImage(frame: .zero)
    private let cameraIconView = CameraIcon(frame: .zero)
    let profileImageOverlayButton = UIButton()
    
    private let nicknameInputView = UIView()
    var nicknameTextField = UITextField()
    private let underlineView = UIView()

    let guideLabel = UILabel()
    let confirmButton = UIButton()
        
    override func configureHierarchy() {
        
        profileImageSectionView.addSubview(profileImageView)
        profileImageSectionView.addSubview(cameraIconView)
        addSubview(profileImageSectionView)
        addSubview(profileImageOverlayButton)
        
        nicknameInputView.addSubview(nicknameTextField)
        nicknameInputView.addSubview(underlineView)
        nicknameInputView.addSubview(guideLabel)
        addSubview(nicknameInputView)
        
        addSubview(confirmButton)
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
        
        cameraIconView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(30)
        }
        
        profileImageOverlayButton.snp.makeConstraints { make in
            make.edges.equalTo(profileImageSectionView)
        }
        
        nicknameInputView.snp.makeConstraints { make in
            make.top.equalTo(profileImageSectionView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(89)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameInputView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        nicknameTextField.textColor = .white
        nicknameTextField.placeholder = "닉네임을 입력해보세요"
        nicknameTextField.borderStyle = .none
        nicknameTextField.tintColor = .accent
        
        underlineView.backgroundColor = .white
        
        guideLabel.text = ""
        guideLabel.textColor = .accent
        guideLabel.textAlignment = .left
        
        confirmButton.setTitle("완료", for: .normal)
        confirmButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        confirmButton.layer.cornerRadius = 25
        confirmButton.layer.borderWidth = 1
        confirmButton.backgroundColor = .clear
    }
    
}
