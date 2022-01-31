//
//  GalleryViewCell.swift
//  UI_app
//
//  Created by Вячеслав on 16.08.2021.
//

import UIKit

final class GalleryViewCell: UICollectionViewCell {
    
    @IBOutlet private var GalleryImageView: UIImageView!
    @IBOutlet private var Like: Like!
    
    
    
    // передаём состояние лайка
    var likeTapped: ((Bool) -> Void)?
    static let identifier: String = "GalleryViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Like.addTarget(self, action: #selector(likeChanged), for: .valueChanged)
    }
    
    func configure(gallery: PhotoStruct) {
        GalleryImageView.loadPhoto(url: gallery.sizes[2].url)
        GalleryImageView.layer.cornerRadius = 10
        GalleryImageView.isUserInteractionEnabled = true
        Like.configure(isLike: (gallery.likes.userLikes != 0), count: gallery.likes.count)
    }
    
    @objc private func likeChanged() {
        likeTapped?(Like.isLike)
    }
}
