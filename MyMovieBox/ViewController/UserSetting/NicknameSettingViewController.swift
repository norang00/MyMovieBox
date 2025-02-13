//
//  NicknameSettingViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/25/25.
//

import UIKit

final class NicknameSettingViewController: BaseViewController {

    let nicknameSettingView = NicknameSettingView()

    var isNewUser: Bool = true
    private var profileImageName = ""
    private var profileNickname = ""
    
    private var userEditing = false
    private var tempNickname = ""

    private var saveButton: UIBarButtonItem?
    private var xButton: UIBarButtonItem?
    var editingDone: (() -> Void)?

    private var isConfirmed: Bool = false {
        didSet {
            configureConfirmButton(isConfirmed)
            saveButton?.isEnabled = isConfirmed
        }
    }
    
    override func loadView() {
        view = nicknameSettingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(isNewUser ?
                            Resources.Title.profileSetNav.rawValue:
                            Resources.Title.profileEditNav.rawValue)
        
        if !isNewUser {
            saveButton = UIBarButtonItem(
                title: Resources.Title.save.rawValue,
                style: .done, target: self, action: #selector(confirmButtonTapped))
            xButton = UIBarButtonItem(
                image: UIImage(systemName: Resources.ImageName.cancel.rawValue),
                style: .plain, target: self, action: #selector(dismissView))
            self.navigationItem.leftBarButtonItem = xButton
            nicknameSettingView.confirmButton.isHidden = true
            saveButton?.isEnabled = false
            self.navigationItem.rightBarButtonItem = saveButton
        }
        
        configureProfileImageView()
        configureConfirmButton(isConfirmed)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNicknameTextField()
        if !isConfirmed && !tempNickname.isEmpty {
            checkNicknameConstraints(tempNickname)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let input = nicknameSettingView.nicknameTextField.text {
            tempNickname = input
        }
    }
    
    @objc
    func dismissView() {
        dismiss(animated: true)
    }
}

// MARK: - profileImageView
extension NicknameSettingViewController {
    
    private func configureProfileImageView() {
        profileImageName = isNewUser ? "profile_\(Int.random(in: 0...11))" : User.profileImageName
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
        nicknameSettingView.nicknameTextField.text = userEditing ? tempNickname : User.nickname
        profileNickname = userEditing ? tempNickname : User.nickname
        nicknameSettingView.guideLabel.text = ""
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let inputText = textField.text else { return }
        userEditing = true
        isConfirmed = checkNicknameConstraints(inputText)
    }

    @discardableResult
    private func checkNicknameConstraints(_ inputText: String) -> Bool {
        var result = false
        var guideText = ""
       
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
        nicknameSettingView.confirmButton.setTitleColor(isConfirmed ? .accent : .gray2, for: .normal)
        nicknameSettingView.confirmButton.layer.borderColor = isConfirmed ? UIColor.accent.cgColor : UIColor.gray2.cgColor
    }
    
    @objc
    private func confirmButtonTapped() {
        User.profileImageName = profileImageName
        User.nickname = profileNickname
        User.signUpDate = DateFormatter.profileDateFormatter.string(from: Date())
        
        if isNewUser {
            let tabBarController = SceneDelegate.getMainTabBarController()
            guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            let window = windowsScene.windows.first
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        } else {
            dismiss(animated: true)
        }
        
        userEditing = false
        editingDone?()
    }
    
}

// MARK: - Hide Keyboard
extension NicknameSettingViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
