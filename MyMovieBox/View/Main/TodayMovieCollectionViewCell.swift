//
//  TodayMovieCollectionViewCell.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit

class TodayMovieCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    let posterImageView = UIImageView()
    
    let titleStackView = UIStackView()
    let titleLabel = UILabel()
    let likeButton = UIButton()
 
    let descriptionLabel = UILabel()
    
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
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(likeButton)
        contentView.addSubview(descriptionLabel)
    }
    
    private func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureView() {
        posterImageView.image = UIImage(systemName: "star")
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.backgroundColor = .bgGray
        
        titleLabel.text = "movie title"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.backgroundColor = .gray
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .accent
        
        descriptionLabel.text = "movie description\nmovie description"
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
        descriptionLabel.backgroundColor = .cardBgGray
    }
    
    // MARK: - Data Setting
    func configureData(_ movie: Movie, _ isLiked: Bool){
        posterImageView.image = UIImage(systemName: "star")

        if isLiked {
            likeButton.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        }
    }
}
