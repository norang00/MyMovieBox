//
//  MainViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
   
    let tempButton = {
        let button = UIButton()
        button.setTitle("user 지우기", for: .normal)
        return button
    }()
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("MainViewController")
        
        configureNavigation("My Movie Box")
        
        view.addSubview(tempButton)
        tempButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview().offset(15)
        }
        tempButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }

    @objc func buttonTapped() {
        User.reset()
        guard let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let window = windowsScene.windows.first
        window?.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        window?.makeKeyAndVisible()
    }
}
