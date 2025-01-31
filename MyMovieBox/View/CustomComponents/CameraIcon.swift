//
//  CameraIcon.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/27/25.
//

import UIKit

final class CameraIcon: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 13)
        let cameraImage = UIImage(systemName: "camera.fill", withConfiguration: symbolConfig)

        image = cameraImage
        contentMode = .center
        tintColor = .white
        layer.cornerRadius = 15
        layer.backgroundColor = UIColor.accent.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
