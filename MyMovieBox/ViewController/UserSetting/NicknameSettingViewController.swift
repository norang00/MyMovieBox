//
//  NicknameSettingViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/25/25.
//

import UIKit

final class NicknameSettingViewController: BaseViewController {

    private let nicknameSettingView = NicknameSettingView()

    var isNewUser: Bool = true
    var profileImageName = ""
    var profileNickname = ""

    private var isConfirmed: Bool = false {
        didSet {
            configureConfirmButton(isConfirmed)
        }
    }
    
    override func loadView() {
        view = nicknameSettingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(isNewUser ? "프로필 설정" : "프로필 편집")
        
        if !isNewUser {
            // TODO: 신규가입이 아닐때의 네비게이션
            navigationController?.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "xmark")
            navigationController?.navigationItem.leftBarButtonItem?.action = #selector(dismiss)
            navigationController?.navigationItem.rightBarButtonItem?.title = "저장"
            navigationController?.navigationItem.rightBarButtonItem?.action = #selector(confirmButtonTapped)
            
            nicknameSettingView.confirmButton.isHidden = true
        }
        
        configureProfileImageView()
        configureNicknameTextField()
        configureConfirmButton(isConfirmed)
    }
}

// MARK: - profileImageView
extension NicknameSettingViewController {
    
    func configureProfileImageView() {
        profileImageName = "profile_\(Int.random(in: 0...11))"
        nicknameSettingView.profileImageView.image = UIImage(named: profileImageName)
        nicknameSettingView.profileImageOverlayButton.addTarget(self, action: #selector(profileImageViewTapped), for: .touchUpInside)
    }
    
    @objc
    private func profileImageViewTapped() {
        let nextVC = ImageSettingViewController()
        nextVC.isNewUser = isNewUser
        nextVC.profileImageName = profileImageName
        nextVC.selectedImageName = { value in
            self.profileImageName = value
            self.nicknameSettingView.profileImageView.image = UIImage(named: value)
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - nicknameTextField
extension NicknameSettingViewController: UITextFieldDelegate {
    
    private func configureNicknameTextField() {
        nicknameSettingView.nicknameTextField.delegate = self
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
        
        nicknameSettingView.guideLabel.text = guideText
        return result
    }
}

// MARK: - confirmButton
extension NicknameSettingViewController {
    
    private func configureConfirmButton(_ isConfirmed: Bool) {
        nicknameSettingView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        nicknameSettingView.confirmButton.isEnabled = isConfirmed
        nicknameSettingView.confirmButton.setTitleColor(isConfirmed ? .accent : .bgGray, for: .normal)
        nicknameSettingView.confirmButton.layer.borderColor = isConfirmed ? UIColor.accent.cgColor : UIColor.bgGray.cgColor
    }
    
    @objc
    private func confirmButtonTapped() {
        User.profileImageName = profileImageName
        User.nickname = profileNickname
        User.signUpDate = DateFormatter.profileDateFormatter.string(from: Date())

        if isNewUser {
            guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            let window = windowsScene.windows.first
            window?.rootViewController = UINavigationController(rootViewController: MainViewController())
            window?.makeKeyAndVisible()
        } else {
            dismiss(animated: true)
        }
    }
}

// MARK: - Hide Keyboard
extension NicknameSettingViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
