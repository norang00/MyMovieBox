//
//  ProfileViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let profileView = ProfileView()
    
    let rowTitles = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation("설정")
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureProfileCard()
    }
}

// 프로필 카드
extension ProfileViewController {
    
    func configureProfileCard() {
        profileView.profileCard.profileImageView.image = UIImage(named: User.profileImageName)
        profileView.profileCard.nicknameLabel.text = User.nickname
        profileView.profileCard.movieBoxLabel.text = "\(User.likedMovies.count)개의 무비박스 보관중"
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

// 설정 테이블뷰
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
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
            showQuitAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showQuitAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {_ in 
            User.reset()
            
            guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            let window = windowsScene.windows.first
            window?.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
            window?.makeKeyAndVisible()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
