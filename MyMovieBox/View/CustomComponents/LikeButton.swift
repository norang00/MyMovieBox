//
//  LikeButton.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/28/25.
//

import UIKit
import SnapKit

class LikeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(systemName: "heart"), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        bounds.size = CGSize(width: 30, height: 30)
        tintColor = .accent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
