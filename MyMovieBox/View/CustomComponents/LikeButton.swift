//
//  LikeButton.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit

final class LikeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(systemName: "heart"), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        tintColor = .accent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            setImage(UIImage(systemName: isSelected ? "heart.fill" : "heart"), for: .normal)
        }
    }
}
