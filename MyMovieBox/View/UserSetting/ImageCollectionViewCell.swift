//
//  ImageCollectionViewCell.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit
import SnapKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let profileImageView = CircleImage(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.alpha = 0.5
        profileImageView.layer.borderColor = UIColor.gray2.cgColor
    }
    
    // MARK: - View Setting
    private func configureHierarchy() {
        contentView.addSubview(profileImageView)
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureView() {
        profileImageView.alpha = 0.5
        profileImageView.layer.borderColor = UIColor.gray2.cgColor
        profileImageView.layer.cornerRadius = frame.size.width/2
    }
    
    // MARK: - Data Setting
    func configureData(_ imageName: String, _ isSelected: Bool){
        profileImageView.image = UIImage(named: imageName)

        if isSelected {
            profileImageView.alpha = 1.0
            profileImageView.layer.borderColor = UIColor.accent.cgColor
        }
    }
}
