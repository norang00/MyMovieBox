//
//  SettingTableViewCell.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/31/25.
//

import UIKit
import SnapKit

final class SettingTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setting
    private func configureHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(12)
        }
    }
    
    private func configureView() {
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - Data Setting
    func configureData(_ title: String) {
        titleLabel.text = title
    }
    
}
