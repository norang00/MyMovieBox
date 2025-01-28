//
//  TodayMovieCollectionViewCell.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit
import Kingfisher

class TodayMovieCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    let posterImageView = UIImageView()
    
    let titleStackView = UIStackView()
    let titleLabel = UILabel()
    let likeButton = LikeButton()
 
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
            make.height.equalTo(310)
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
        
        titleStackView.distribution = .fillProportionally
        
        titleLabel.text = "movie title"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        descriptionLabel.text = "movie description\nmovie description"
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    // MARK: - Data Setting
    func configureData(_ movie: Movie, _ isLiked: Bool){
        let url = "https://image.tmdb.org/t/p/w500"+movie.posterPath
        guard let imageURL = URL(string: url) else { return }
        posterImageView.kf.setImage(with: imageURL)
        
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        
        if isLiked {
            likeButton.setImage(UIImage(systemName: isLiked ? "heart.fill" : "heart"), for: .normal)
        }
    }
}
