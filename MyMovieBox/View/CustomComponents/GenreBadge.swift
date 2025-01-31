//
//  GenreBadge.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/29/25.
//

import UIKit

final class GenreBadge: UILabel {
    private var padding = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = .white
        textAlignment = .center
        font = .systemFont(ofSize: 12, weight: .semibold)
        layer.cornerRadius = 4
        layer.backgroundColor = UIColor.genreBadgeGray.cgColor
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
