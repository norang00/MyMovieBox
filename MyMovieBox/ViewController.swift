//
//  ViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    let label = {
        let label = UILabel()
        label.text = "on boarding or main?"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }


}

