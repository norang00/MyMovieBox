//
//  CircleImageView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/26/25.
//

import UIKit

final class CircleImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFit
        layer.borderWidth = 3
        layer.borderColor = UIColor.accent.cgColor
        layer.cornerRadius = 50
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
