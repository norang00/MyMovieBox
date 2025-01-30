//
//  DetailView.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/30/25.
//

import UIKit
import SnapKit

final class DetailView: BaseView {

    let backdropCollectionView = BackdropCollectionView(frame: .zero,
                                                        collectionViewLayout: BackdropCollectionView.createCollectionViewLayout())
    let movieDescription = UILabel()

    let synopsisLabel = UILabel()
    let synopsisButton = UIButton()
    let synopsisContentLabel = UILabel()

    let castLabel = UILabel()
    //let castCollectionView =
    
    let posterLabel = UILabel()
//    let posterCollectioinView =
    
    override func configureHierarchy() {
        [backdropCollectionView, movieDescription].forEach {
            addSubview($0)
        }

        [synopsisLabel, synopsisButton, synopsisContentLabel].forEach {
            addSubview($0)
        }
        
        [castLabel/*, castCollectionView*/].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        backdropCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.width*0.8)
        }
       
    }
    
    override func configureView() {
        super.configureView()
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
