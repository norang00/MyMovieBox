//
//  GenreBadge.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/29/25.
//

import UIKit

// Label custom 참고 https://jeonyeohun.tistory.com/248
class GenreBadge: UILabel {
    var padding = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        textAlignment = .center
        font = .systemFont(ofSize: 14, weight: .semibold)
        layer.cornerRadius = 4
        layer.backgroundColor = UIColor.bgGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = padding
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}
