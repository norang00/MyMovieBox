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
    // UIPageControl 구현 참고: https://taekki-dev.tistory.com/25
    var backdropPageControl = UIPageControl()
    let movieDescription = UILabel()

    let synopsisLabel = UILabel()
    let synopsisButton = UIButton()
    let synopsisContentLabel = UILabel()

    let castLabel = UILabel()
    //let castCollectionView =
    
    let posterLabel = UILabel()
//    let posterCollectioinView =
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [backdropCollectionView, backdropPageControl, movieDescription].forEach {
            contentView.addSubview($0)
        }

        [synopsisLabel, synopsisButton, synopsisContentLabel].forEach {
            contentView.addSubview($0)
        }
        
        [castLabel/*, castCollectionView*/].forEach {
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
            make.bottom.equalTo(backdropCollectionView).inset(16)
        }
        
        movieDescription.snp.makeConstraints { make in
            make.centerX.equalTo(backdropCollectionView)
            make.top.equalTo(backdropCollectionView.snp.bottom).offset(12)
            make.height.equalTo(500)
            make.bottom.equalTo(contentView).offset(-20)
        }
       
    }
    
    override func configureView() {
        super.configureView()
        
        scrollView.showsVerticalScrollIndicator = false
        
        backdropPageControl.backgroundStyle = .prominent
                
        movieDescription.text = "askflaslkfaslkfmaslkdfalskdfasldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\nsldkfmaslkdf\n"
        movieDescription.numberOfLines = 0

        
        //
//        recentSearchLabel.text = "최근검색어"
//        recentSearchLabel.font = .systemFont(ofSize: 20, weight: .bold)
//        
//        recentSearchDeleteButton.setTitle("전체 삭제", for: .normal)
//        recentSearchDeleteButton.setTitleColor(.accent, for: .normal)
//        
//        recentSearchEmptyLabel.text = "최근 검색어 내역이 없습니다."
//        recentSearchEmptyLabel.textColor = .titleGray
//        recentSearchEmptyLabel.font = .systemFont(ofSize: 16, weight: .medium)
//        
//        recentSearchScrollView.isScrollEnabled = true
//        recentSearchScrollView.showsHorizontalScrollIndicator = false
//        recentSearchScrollView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//        
//        recentSearchStackView.axis = .horizontal
//        recentSearchStackView.spacing = 8
//        recentSearchStackView.distribution = .equalSpacing
//        
//        todayMovieLabel.text = "오늘의 영화"
//        todayMovieLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
}
