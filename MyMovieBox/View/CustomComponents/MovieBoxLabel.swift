//
//  MovieBoxLabel.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/31/25.
//

import UIKit

final class MovieBoxLabel: UILabel {
    private var padding = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        text = "\(User.likedMovies.count)개의 무비박스 보관중"
        textAlignment = .center
        font = .systemFont(ofSize: 14, weight: .bold)
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor.moviebox.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
