//
//  ProfileNicknameViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/25/25.
//

import UIKit

class ProfileNicknameViewController: UIViewController {

    let profileNicknameView = ProfileNicknameView()
    var isNewUser: Bool = true
    
    override func loadView() {
        view = profileNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = isNewUser ? "프로필 설정" : "프로필 편집"
    }
    


}
