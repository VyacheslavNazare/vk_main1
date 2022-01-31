//
//  ProfileViewController.swift
//  UI_app
//
//  Created by Вячеслав on 27.11.2021.
//

import UIKit


class ProfileViewController: UIViewController {
    

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var bDate: UILabel!
    @IBOutlet weak var buttonGroups: UIButton!
    @IBOutlet weak var buttonFriends: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    
    let profileAPI = ProfileAPI()
    var profile: [ProfileModel] = []

    let photoAPI = MyPhotoAPI()
    var gallery: [MyPhotoStruct] = []
    
    let countCell:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonGroups.layer.shadowOpacity = 0.5
        buttonGroups.layer.shadowOffset = CGSize(width: 5, height: 8)
        buttonFriends.layer.shadowOpacity = 0.5
        buttonFriends.layer.shadowOffset = CGSize(width: 5, height: 8)
    
        navigationController!.navigationBar.tintColor = UIColor.black
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.borderColor = UIColor.black.cgColor
        buttonGroups.layer.cornerRadius = 5
        buttonFriends.layer.cornerRadius = 5
        buttonFriends.layer.borderWidth = 1.5
        buttonGroups.layer.borderWidth = 1.5
        buttonFriends.layer.borderColor = UIColor.black.cgColor
        buttonGroups.layer.borderColor = UIColor.black.cgColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        
        profileAPI.getProfile { [weak self] profile in
            guard let self = self else { return }
            self.profile = profile
            self.inputData(profile: profile.first!)
            print("profileJSOOOOOOOOOOOON")
        }
        photoAPI.myGetPhotos { [weak self]  photos in
            guard let self = self else { return }
            self.gallery = photos
            self.collectionView.reloadData()
            print("Получили фотo")}
        collectionView.isUserInteractionEnabled = true
    }

    
    func inputData(profile: ProfileModel) {
        bDate.text = profile.bDate
        avatarImage.loadPhoto(url: profile.photo100)
        fullName.text = profile.fullName

    }
    
    
    @IBAction func GroupSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "GroupView1", sender: nil)
    }
    @IBAction func FriendSegue(_ sender: UIButton) {
        performSegue(withIdentifier: "FriendsView1", sender: nil)
    }
    
    
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPhotoTableViewCell.identifier, for: indexPath) as! MyPhotoTableViewCell
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
