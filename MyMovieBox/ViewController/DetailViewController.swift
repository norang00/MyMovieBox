//
//  DetailViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/29/25.
//

import UIKit

class DetailViewController: BaseViewController {

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation(movie!.title)

    }
    
    override func configureNavigation(_ title: String) {
        super.configureNavigation(title)
                
        let likeButton = LikeButton()
        likeButton.isSelected = User.checkLike(movie!.id)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: likeButton)

    }
    
    // MARK: 좋아요 기능
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        print(#function)
        if let index = User.likedMovies.firstIndex(of: movie!.id) {
            User.likedMovies.remove(at: index)
        } else {
            User.likedMovies.append(movie!.id)
        }
        sender.isSelected.toggle()
    }

    
}
