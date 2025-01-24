//
//  MainView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit
import SnapKit

class MainView: BaseView {

    let label = {
        let label = UILabel()
        label.text = "메인"
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(label)
    }

    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .black
    }
    
}
