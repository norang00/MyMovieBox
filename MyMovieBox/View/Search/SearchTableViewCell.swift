//
//  SearchTableViewCell.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let bottomView = UIView()
    let genreStackView = UIStackView()
    let likeButton = LikeButton()
    
    private var genreList: [String] = []
    private var movie: Movie?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = UIImage(systemName: "film")
        posterImageView.contentMode = .scaleAspectFit
        titleLabel.text = ""
        dateLabel.text = ""
        genreStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        genreList = []
    }
    
    // MARK: - View Setting
    private func configureHierarchy() {
        [posterImageView, titleLabel, dateLabel, bottomView].forEach {
            contentView.addSubview($0)
        }
        [genreStackView, likeButton].forEach {
            bottomView.addSubview($0)
        }
    }
    
    private func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.height.equalTo(96)
            make.width.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
        }
        
        bottomView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(12)
        }
        
        genreStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
    private func configureView() {
        posterImageView.image = UIImage(systemName: "film")
        posterImageView.tintColor = .white
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
        
        titleLabel.text = ""
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        dateLabel.text = ""
        dateLabel.textColor = .gray2
        dateLabel.font = .systemFont(ofSize: 14, weight: .medium)

        genreStackView.axis = .horizontal
        genreStackView.spacing = 4
    }
    
    func makeGenreBadge() {
        if genreList.isEmpty {
            print("no genre")
        } else {
            for genre in genreList {
                let label = GenreBadge()
                label.text = genre
                genreStackView.addArrangedSubview(label)
            }
        }
    }
    
    // MARK: - Data Setting
    func configureData(_ movie: Movie, _ isLiked: Bool){
        titleLabel.text = movie.title
        
        guard let date = movie.releaseDate else { return }
        dateLabel.text = date.replacingOccurrences(of: "-", with: ". ")
        
        guard let genre = movie.genreIds else { return }
        genre.prefix(2).forEach {
            let genre = Genre.mapping[$0]
            genreList.append(genre!)
        }

        guard let posterPath = movie.posterPath else { return }
        let url = "https://image.tmdb.org/t/p/w500"+posterPath
        
        guard let imageURL = URL(string: url) else { return }
        posterImageView.kf.setImage(with: imageURL)
        posterImageView.contentMode = .scaleAspectFill
        
        makeGenreBadge()
        likeButton.isSelected = isLiked
    }
}
