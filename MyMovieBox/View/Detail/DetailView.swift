//
//  DetailView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/30/25.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()

    let backdropCollectionView = BackdropCollectionView(frame: .zero,
                                                        collectionViewLayout: BackdropCollectionView.createCollectionViewLayout())
    var backdropPageControl = UIPageControl()
    let movieDescriptionLabel = UILabel()

    let synopsisLabel = UILabel()
    let synopsisButton = UIButton()
    let synopsisContentLabel = UILabel()

    let castLabel = UILabel()
    let castCollectionView = CastCollectionView(frame: .zero,
                                                collectionViewLayout: CastCollectionView.createCollectionViewLayout())
    
    let posterLabel = UILabel()
    let posterCollectionView = PosterCollectionView(frame: .zero,
                                                     collectionViewLayout: PosterCollectionView.createCollectionViewLayout())
    
    let tempLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [backdropCollectionView, backdropPageControl, movieDescriptionLabel].forEach {
            contentView.addSubview($0)
        }
        
        [synopsisLabel, synopsisButton, synopsisContentLabel].forEach {
            contentView.addSubview($0)
        }
        
        [castLabel, castCollectionView].forEach {
            contentView.addSubview($0)
        }
        
        [posterLabel, posterCollectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        backdropCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(UIScreen.main.bounds.width*0.8)
        }
        
        backdropPageControl.snp.makeConstraints { make in
            make.centerX.equalTo(backdropCollectionView)
            make.bottom.equalTo(backdropCollectionView).inset(12)
        }
        
        movieDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backdropCollectionView)
            make.top.equalTo(backdropCollectionView.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(contentView).inset(12)
        }
        
        synopsisLabel.snp.makeConstraints { make in
            make.top.equalTo(movieDescriptionLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).inset(12)
            make.height.equalTo(30)
        }
        
        synopsisButton.snp.makeConstraints { make in
            make.top.equalTo(movieDescriptionLabel.snp.bottom).offset(20)
            make.trailing.equalTo(contentView).inset(12)
            make.bottom.equalTo(synopsisLabel)
        }
        
        synopsisContentLabel.snp.makeConstraints { make in
            make.top.equalTo(synopsisLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(contentView).inset(12)
        }
        
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(synopsisContentLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(12)
        }
        
        castCollectionView.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(120)
        }
        
        posterLabel.snp.makeConstraints { make in
            make.top.equalTo(castCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(12)
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(posterLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(210)
            make.bottom.equalTo(contentView).inset(24)
        }
    }

    override func configureView() {
        super.configureView()
        
        scrollView.showsVerticalScrollIndicator = false
        
        backdropPageControl.backgroundStyle = .prominent
  
        movieDescriptionLabel.font = .systemFont(ofSize: 14, weight: .light)
        movieDescriptionLabel.textColor = .titleGray
        movieDescriptionLabel.numberOfLines = 1
        movieDescriptionLabel.textAlignment = .center
        movieDescriptionLabel.sizeToFit()

        synopsisLabel.text = "Synopsis"
        synopsisLabel.textColor = .white
        synopsisLabel.textAlignment = .left
        synopsisLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        synopsisButton.setTitle("More", for: .normal)
        synopsisButton.setTitleColor(.accent, for: .normal)
        synopsisButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)

        synopsisContentLabel.textColor = .white
        synopsisContentLabel.font = .systemFont(ofSize: 14, weight: .regular)
        synopsisContentLabel.textAlignment = .justified
        synopsisContentLabel.numberOfLines = 3
        
        castLabel.text = "Cast"
        castLabel.textColor = .white
        castLabel.textAlignment = .left
        castLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        posterLabel.text = "Poster"
        posterLabel.textColor = .white
        posterLabel.textAlignment = .left
        posterLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    // NSTextAttachment 사용법 참고:
    // https://nsios.tistory.com/204
    // https://ios-development.tistory.com/1728
    // https://www.hackingwithswift.com/articles/237/complete-guide-to-sf-symbols
    func setMovieDescription(_ date: String, _ vote: String, _ genre: String) -> NSAttributedString {

        let calendarString = getSymbolAttachment("calendar")
        let releaseDate = NSAttributedString(string: "  \(date)")
        
        let starString = getSymbolAttachment("star.fill")
        let voteAverage = NSAttributedString(string: "  \(vote)")
        
        let filmString = getSymbolAttachment("film.fill")
        let genre = NSAttributedString(string: "  \(genre)")

        let fullText = NSMutableAttributedString()
        fullText.append(calendarString)
        fullText.append(releaseDate)
        fullText.append(NSAttributedString(string: "   |   "))
        fullText.append(starString)
        fullText.append(voteAverage)
        fullText.append(NSAttributedString(string: "   |   "))
        fullText.append(filmString)
        fullText.append(genre)
        
        return fullText
    }
    
    func getSymbolAttachment(_ image: String) -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: image)?.withTintColor(.titleGray)
        attachment.bounds = .init(x: 0, y: -3, width: 16, height: 16)
        let attributedString = NSMutableAttributedString(attachment: attachment)
        return attributedString
    }
}
