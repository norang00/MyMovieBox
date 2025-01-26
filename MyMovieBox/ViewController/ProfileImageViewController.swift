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

    override func loadView() {
        view = profileImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(isNewUser ? "프로필 이미지 설정" : "프로필 이미지 편집")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
