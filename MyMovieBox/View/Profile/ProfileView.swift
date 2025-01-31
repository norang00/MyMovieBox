//
//  ProfileView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/31/25.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {

    let profileCard = ProfileCard()
    let settingTableView = SettingTableView()
    
    override func configureHierarchy() {
        addSubview(profileCard)
        addSubview(settingTableView)
    }

    override func configureLayout() {
        profileCard.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(136)
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(profileCard.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(12)
            make.height.equalTo(176)
        }
    }
}
