//
//  BackdropCollectionViewCell.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/30/25.
//

import UIKit
import SnapKit
import Kingfisher

final class BackdropCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }

    let backdropImageView = UIImageView()
    
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
        contentView.addSubview(backdropImageView)
    }
    
    private func configureLayout() {
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureView() {
        backdropImageView.image = UIImage(systemName: "film.circle.fill")
        backdropImageView.contentMode = .scaleAspectFill
        backdropImageView.clipsToBounds = true
      }
    
    // MARK: - Data Setting
    func configureData(_ imagePath: String){
        let url = TMDBRequest.imageBaseURL+imagePath
        guard let imageURL = URL(string: url) else { return }
        backdropImageView.kf.setImage(with: imageURL)                
    }
}
