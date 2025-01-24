//
//  OnboardingViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    override func loadView() {
        view = OnboardingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("OnboardingViewController")
    }
    

}
