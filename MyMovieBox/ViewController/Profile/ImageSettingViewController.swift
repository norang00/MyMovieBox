//
//  ImageSettingViewController.swift
//  MyMovieBox
//
//  Created by Kyuhee hong on 1/26/25.
//

import UIKit

final class ImageSettingViewController: UIViewController {

    private let profileImageSettingView = ImageSettingView()

    var isNewUser: Bool = true
    var profileImageName = ""
    var selectedImageName: ((String) -> Void)?
    
    override func loadView() {
        view = profileImageSettingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(isNewUser ? "프로필 이미지 설정" : "프로필 이미지 편집")

        configureMainImage()
        configureCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        selectedImageName?(profileImageName)
    }
    
    func configureMainImage() {
        profileImageSettingView.profileImageView.image = UIImage(named: profileImageName)
    }
}

// MARK: - CollectionView
extension ImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        profileImageSettingView.collectionView.delegate = self
        profileImageSettingView.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        let imageName = "profile_\(indexPath.row)"
        let isSelectedImage = (imageName == profileImageName)
        cell.configureData(imageName, isSelectedImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageName = "profile_\(indexPath.row)"
        profileImageName = imageName        
        profileImageSettingView.profileImageView.image = UIImage(named: profileImageName)
        collectionView.reloadData()
    }
}
