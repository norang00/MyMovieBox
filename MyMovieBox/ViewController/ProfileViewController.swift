//
//  ProfileViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    let profileView = ProfileView()
    private let rowTitles = Resources.SettingTitles.allCases.map { $0.rawValue }
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation(Resources.Title.setting.rawValue)
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureProfileCard()
    }
}

// MARK: - 프로필 카드
extension ProfileViewController {
    
    private func configureProfileCard() {
        profileView.profileCard.profileImageView.image = UIImage(named: User.profileImageName)
        profileView.profileCard.nicknameLabel.text = User.nickname
        profileView.profileCard.movieBoxLabel.text = "\(User.likedMovies.count)"+Resources.Title.likedMovie.rawValue
        profileView.profileCard.overlayButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
    }
    
    @objc func profileTapped() {
        let nicknameVC = NicknameSettingViewController()
        nicknameVC.isNewUser = false
        nicknameVC.editingDone = {
            self.configureProfileCard()
        }
        let nextVC = UINavigationController(rootViewController: nicknameVC)
        present(nextVC, animated: true)
    }
}

// MARK: - 설정 테이블뷰
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        profileView.settingTableView.delegate = self
        profileView.settingTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        cell.configureData(rowTitles[indexPath.row])
        if indexPath.row != 3 {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            showQuitAlert(title: Resources.Alert.Title.quit.rawValue,
                          message: Resources.Alert.Message.quit.rawValue)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func showQuitAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Resources.Title.check.rawValue, style: .default) {_ in
            User.reset()
            
            guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            let window = windowsScene.windows.first
            window?.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
            window?.makeKeyAndVisible()
        }
        
        let cancelAction = UIAlertAction(title: Resources.Title.cancel.rawValue, style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
