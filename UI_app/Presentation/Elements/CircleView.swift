//
//  CircleView.swift
//  UI_app
//
//  Created by Вячеслав on 25.08.2021.
//

import UIKit

class CircleView: UIView {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        DispatchQueue.main.async {
            self.addSubview(self.imageView)
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.black.cgColor
            self.imageView.clipsToBounds = true
            self.layer.shadowColor = UIColor.systemGray.cgColor
            self.layer.shadowOffset = CGSize(width: 10, height: 10)
            self.layer.shadowRadius = 10
            self.layer.shadowOpacity = 0.9
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        DispatchQueue.main.async {
            self.imageView.frame = self.bounds
            let radius = self.frame.size.width / 2

            self.layer.cornerRadius = radius
            self.imageView.layer.cornerRadius = radius
        }
    }

    func setImageLoad(_ urlString: String) {
        DispatchQueue.main.async {
            guard let url = URL(string: urlString) else { return }
            self.imageView.loadPhoto(url: url)
        }
    }
    func setImage(_ image: UIImage?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}

 
    

