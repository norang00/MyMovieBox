//
//  PosterCollectionViewCell.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/30/25.
//

import UIKit
import SnapKit
import Kingfisher

final class PosterCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let posterImageView = UIImageView()
    
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
    }
    
    private func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureView() {
        posterImageView.image = UIImage(systemName: "film.circle.fill")
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
    }
    
    // MARK: - Data Setting
    func configureData(_ imagePath: String){
        let url = TMDBRequest.imageBaseURL+imagePath
        guard let imageURL = URL(string: url) else { return }
        posterImageView.kf.setImage(with: imageURL)
    }
}
