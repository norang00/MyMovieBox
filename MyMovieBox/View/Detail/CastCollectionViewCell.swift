//
//  CastCollectionViewCell.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/30/25.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    let castImageView = UIImageView()
    let castStackView = UIStackView()
    let castNameLabel = UILabel()
    let castCharacterLabel = UILabel()
    
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
    }
    
    // MARK: - View Setting
    private func configureHierarchy() {
        contentView.addSubview(castImageView)
        contentView.addSubview(castStackView)
        castStackView.addArrangedSubview(castNameLabel)
        castStackView.addArrangedSubview(castCharacterLabel)
    }
    
    private func configureLayout() {
        castImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(5)
            make.leading.equalTo(contentView).offset(12)
            make.size.equalTo(50)
        }
        
        castStackView.snp.makeConstraints { make in
            make.centerY.equalTo(castImageView)
            make.leading.equalTo(castImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).inset(8)
        }
    }
    
    private func configureView() {
        castImageView.image = UIImage(systemName: "film.circle.fill")
        castImageView.contentMode = .scaleAspectFill
        castImageView.layer.cornerRadius = 25
        castImageView.clipsToBounds = true
        
        castStackView.axis = .vertical
        castStackView.spacing = 4
        castStackView.alignment = .leading
        
        castNameLabel.textColor = .white
        castNameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        castNameLabel.adjustsFontSizeToFitWidth = true

        castCharacterLabel.textColor = .gray1
        castCharacterLabel.font = .systemFont(ofSize: 12, weight: .regular)
        castCharacterLabel.adjustsFontSizeToFitWidth = true
      }
    
    // MARK: - Data Setting
    func configureData(_ cast: Cast){
        guard let profilePath = cast.profilePath else { return }
        let url = "https://image.tmdb.org/t/p/w500"+profilePath
        guard let imageURL = URL(string: url) else { return }
        castImageView.kf.setImage(with: imageURL)
        castNameLabel.text = cast.name
        castCharacterLabel.text = cast.character
    }
}
