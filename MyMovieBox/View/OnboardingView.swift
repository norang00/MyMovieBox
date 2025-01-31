//
//  OnboardingView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/24/25.
//

import UIKit
import SnapKit

final class OnboardingView: BaseView {
   
    private let onboardImageView = UIImageView()
    private let onboardingLabel = UILabel()
    private let welcomeLabel = UILabel()
    let startButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(onboardImageView)
        addSubview(onboardingLabel)
        addSubview(welcomeLabel)
        addSubview(startButton)
    }

    override func configureLayout() {
        onboardImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        onboardingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(onboardImageView.snp.bottom)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(onboardingLabel.snp.bottom).offset(10)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()

        onboardImageView.image = UIImage(named: "onboarding")
        onboardImageView.contentMode = .scaleAspectFit
        
        onboardingLabel.text = "Onboarding"
        onboardingLabel.textColor = .white
        onboardingLabel.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 30)

        welcomeLabel.text = "당신만의 영화 상자,\nMyMovieBox를 시작해보세요."
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        welcomeLabel.numberOfLines = 2
        
        startButton.setTitleColor(.accent, for: .normal)
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        startButton.layer.cornerRadius = 25
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.accent.cgColor
        startButton.backgroundColor = .clear
    }
}
