//
//  ProfileTableViewCell.swift
//  UI_app
//
//  Created by Вячеслав on 27.11.2021.
//

import UIKit

class MyPhotoTableViewCell: UICollectionViewCell {
   
    static let identifier = "MyPhotoTableViewCell"
    @IBOutlet weak var MyPhoto: UIImageView!

    func configure(gallery: MyPhotoStruct) {
        MyPhoto.loadPhoto(url: gallery.sizes[2].url)
        MyPhoto.layer.cornerRadius = 10
    }
}
