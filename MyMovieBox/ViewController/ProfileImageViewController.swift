//
//  ProfileImageViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/26/25.
//

import UIKit

final class ProfileImageViewController: UIViewController {

    private let profileImageView = ProfileImageView()
    var isNewUser: Bool = true
    var profileImageName = ""

    override func loadView() {
        view = profileImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(isNewUser ? "프로필 이미지 설정" : "프로필 이미지 편집")

        configureMainImage()
    }
    
    func configureMainImage() {
        profileImageView.profileImageView.image = UIImage(named: profileImageName)
    }
    
    
}
