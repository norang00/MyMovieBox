//
//  ProfileNicknameView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/25/25.
//

import UIKit

final class ProfileNicknameView: BaseView {

    private let profileImageSectionView = UIView()
    let profileImageView = CircleImageView(frame: .zero)
    private let cameraImageView = UIImageView()
    let profileImageOverlayButton = UIButton()
    
    private let nicknameInputView = UIView()
    let nicknameTextField = UITextField()
    private let underlineView = UIView()

    let guideLabel = UILabel()

    let confirmButton = UIButton()
    
    override func configureHierarchy() {
        
        profileImageSectionView.addSubview(profileImageView)
        profileImageSectionView.addSubview(cameraImageView)
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
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(30)
        }
        
        profileImageOverlayButton.snp.makeConstraints { make in
            make.edges.equalTo(profileImageSectionView)
        }
        
        nicknameInputView.snp.makeConstraints { make in
            make.top.equalTo(profileImageSectionView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(89)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(underlineView.snp.bottom)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
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
        
        profileImageOverlayButton.layer.cornerRadius = 16
        
        nicknameInputView.backgroundColor = .clear
        
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
