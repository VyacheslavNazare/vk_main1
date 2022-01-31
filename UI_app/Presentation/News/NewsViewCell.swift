//
//  NewsViewCell.swift
//  UI_app
//
//  Created by Вячеслав on 04.09.2021.
//

import UIKit

class NewsViewCell: UITableViewCell {

    static let identifier = "NewsViewCell"
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var creatoreName: UILabel!
    @IBOutlet var textPost: UILabel!
    @IBOutlet var likeLable: UILabel!
    
    func configure(news: NewsModel) {
        DispatchQueue.global(qos: .userInteractive).sync {
            self.creatoreName.text = news.creatorName
            if news.text.isEmpty {
                return
            } else {
                self.textPost.text = news.text
            }
            self.avatar.loadPhoto(url: news.avatarURL!)
            self.likeLable.text = String("Нравится: \(news.likes.count)")
            if news.attachments[0].type == "photo" {
                self.mainImage.layer.cornerRadius = 10
                self.mainImage.layer.borderWidth = 2
                self.mainImage.layer.borderColor = UIColor.black.cgColor
                self.mainImage.clipsToBounds = true
                self.mainImage.layer.shadowColor = UIColor.systemGray.cgColor
                self.mainImage.layer.shadowOffset = CGSize(width: 10, height: 10)
                self.mainImage.layer.shadowRadius = 10
                self.mainImage.layer.shadowOpacity = 0.9
                self.mainImage.loadPhoto(url: URL(string: (news.photosURL.first)!)!)
            } else {
                self.mainImage.image = UIImage(named: "121")
            }
        }
    }
}
