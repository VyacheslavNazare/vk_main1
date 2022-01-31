//
//  GalleryViewController.swift
//  UI_app
//
//  Created by Вячеслав on 16.08.2021.
//

import UIKit

class GalleryViewController: UIViewController {
    
    let photoAPI = PhotoAPI()
    let ProfileSelectFriend = ProfileSelectFriends()
    
    
    
    @IBOutlet var date: UILabel!
    @IBOutlet var gender: UILabel!
    
    @IBOutlet var city: UILabel!
    @IBOutlet var fullNameSelectFriends: UILabel!
    @IBOutlet var avatarSelectFriends: UIImageView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var gallery: [PhotoStruct] = []
    var profile: [ProfileSelectFriendsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.tintColor = UIColor.black
        avatarSelectFriends.layer.borderWidth = 3
        avatarSelectFriends.layer.borderColor = UIColor.black.cgColor
        collectionView.delegate = self
        collectionView.dataSource = self
        
        ProfileSelectFriend.getProfileSelectFriends { [weak self] profile in
            guard let self = self else { return }
            self.profile = profile
            self.inputData(profile: profile.first!)
        }
        photoAPI.getPhotos { photos in
            self.gallery = photos
            self.collectionView.reloadData()
        }
    }
    func inputData(profile: ProfileSelectFriendsModel) {
        avatarSelectFriends.loadPhoto(url: profile.photo100)
        fullNameSelectFriends.text = profile.fullName
        gender.text = "Дата: " + profile.bdate
        if profile.sex == 1 {
            date.text = "Пол: Женский"
        } else if profile.sex == 2 {
            date.text = "Пол: Мужской"
        } else {
            date.text = "Пол: Не указан"
        }
    }
    
}


extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryViewCell.identifier, for: indexPath) as! GalleryViewCell
        let gallerys = gallery[indexPath.item]
        cell.configure(gallery: gallerys)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameView = collectionView.frame
        let widthCell = frameView.width
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }
    
}
