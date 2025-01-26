//
//  UIViewController+Extension.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/25/25.
//

import UIKit

extension UIViewController {
    
    func configureNavigationTitle(_ title: String = "") {
        navigationItem.title = title
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            print("Alert confirm clicked")
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
}
