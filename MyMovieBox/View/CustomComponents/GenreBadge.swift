//
//  GenreBadge.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/29/25.
//

import UIKit

// Label custom 참고 https://jeonyeohun.tistory.com/248
class GenreBadge: UILabel {
    let verticalInset: CGFloat = 2
    let horizontalInset: CGFloat = 6
    
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
        let insets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + horizontalInset*2,
                      height: size.height + verticalInset*2)
    }
}
