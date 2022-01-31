//
//  GalleryGroupViewController.swift
//  UI_app
//
//  Created by Вячеслав on 23.08.2021.
//

import UIKit

class GalleryGroupViewController: UIViewController {
    
    private let galleryGroupAPI = GalleryGroupAPI()
    private var galleryGroups: [GroupPhotoStruct] = []

    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var avatarGroup: UIImageView!
    
    static var selectDescriptionText: String!
    static var selectAvatarGroup: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionText.backgroundColor = .lightGray
        descriptionText.layer.masksToBounds = true
        descriptionText.layer.cornerRadius = 10
        descriptionText.text = GalleryGroupViewController.selectDescriptionText
        avatarGroup.layer.borderWidth = 2
        avatarGroup.layer.borderColor = UIColor.black.cgColor
        avatarGroup.loadPhoto(url: GalleryGroupViewController.selectAvatarGroup)

        navigationController!.navigationBar.tintColor = UIColor.black
        collectionView.delegate = self
        collectionView.dataSource = self
        galleryGroupAPI.getPhotosGroup { [weak self] galleryGroups in
            guard let self = self else { return }
            self.galleryGroups = galleryGroups
            self.collectionView.reloadData()
        }
    }
}

extension GalleryGroupViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        galleryGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryGroupViewCell.identifier, for: indexPath) as! GalleryGroupViewCell
        let galleryGroup = galleryGroups[indexPath.item]
        cell.configure(galleryGroup)
        return cell
    }
}
