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
        
        configureNicknameTextField()
        configureConfirmButton(isConfirmed)
    }
    
}

// MARK: - profileImageView
extension ProfileNicknameViewController {
    

    
    private func profileSectionTapped() {
        let nextVC = ProfileImageViewController()
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
        
        guard let profileImageName = profileNicknameView.profileImageView.image?.description else { return }
        guard let profileNickname = profileNicknameView.nicknameTextField.text else { return }
        User.profileImageName = profileImageName
        User.nickname = profileNickname
        
        print(User.self)
        let nextVC = MainViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
