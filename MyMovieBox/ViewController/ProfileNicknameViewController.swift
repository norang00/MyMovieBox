//
//  ProfileNicknameViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/25/25.
//

import UIKit

final class ProfileNicknameViewController: UIViewController {

    private let profileNicknameView = ProfileNicknameView()

    var isNewUser: Bool = true
    var profileImageName = ""
    var profileNickname = ""

    private var isConfirmed: Bool = false {
        didSet {
            configureConfirmButton(isConfirmed)
        }
    }
    
    override func loadView() {
        view = profileNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(isNewUser ? "프로필 설정" : "프로필 편집")
        
        configureImageView()
        configureNicknameTextField()
        configureConfirmButton(isConfirmed)
    }
    
}

// MARK: - profileImageView
extension ProfileNicknameViewController {
    
    func configureImageView() {
        profileImageName = "profile_\(Int.random(in: 0...11))"
        profileNicknameView.profileImageView.image = UIImage(named: profileImageName)
        
        profileNicknameView.profileImageOverlayButton.addTarget(self, action: #selector(profileImageViewTapped), for: .touchUpInside)
    }
    
    @objc
    private func profileImageViewTapped() {
        let nextVC = ProfileImageViewController()
        nextVC.profileImageName = profileImageName
        nextVC.isNewUser = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - nicknameTextField
extension ProfileNicknameViewController: UITextFieldDelegate {
    
    private func configureNicknameTextField() {
        profileNicknameView.nicknameTextField.delegate = self
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let inputText = textField.text else { return }
        isConfirmed = checkNicknameConstraints(inputText)
    }

    private func checkNicknameConstraints(_ inputText: String) -> Bool {
        var result = false
        var guideText = ""

        // 문자열 검증 참고:
        // https://developerbee.tistory.com/25
        // https://sarunw.com/posts/how-to-check-if-string-is-number-in-swift/
        let specialCharacters = CharacterSet(charactersIn: "@#$%")
        let numberCharacters = CharacterSet.decimalDigits
        
        if inputText.count < 2 || inputText.count > 10 {
            guideText = "2글자 이상 10글자 미만으로 설정해 주세요"
        } else if inputText.rangeOfCharacter(from: specialCharacters) != nil {
            guideText = "닉네임에 @, #, $, % 는 포함할 수 없어요"
        } else if inputText.rangeOfCharacter(from: numberCharacters) != nil {
            guideText = "닉네임에 숫자는 포함할 수 없어요"
        }else {
            guideText = "사용할 수 있는 닉네임이에요"
            profileNickname = inputText
            result = true
        }
        
        profileNicknameView.guideLabel.text = guideText
        return result
    }
    
}

// MARK: - confirmButton
extension ProfileNicknameViewController {
    
    private func configureConfirmButton(_ isConfirmed: Bool) {
        profileNicknameView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        profileNicknameView.confirmButton.isEnabled = isConfirmed
        profileNicknameView.confirmButton.setTitleColor(isConfirmed ? .accent : .bgGray, for: .normal)
        profileNicknameView.confirmButton.layer.borderColor = isConfirmed ? UIColor.accent.cgColor : UIColor.bgGray.cgColor
    }
    
    @objc
    private func confirmButtonTapped() {
        print(#function)
        
        User.profileImageName = profileImageName
        User.nickname = profileNickname
 
        guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let window = windowsScene.windows.first
        let nextVC = MainViewController()
        window?.rootViewController = UINavigationController(rootViewController: nextVC)
        window?.makeKeyAndVisible()
    }
}
