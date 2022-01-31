//
//  ExtentionImageView.swift
//  UI_app
//
//  Created by Вячеслав on 13.11.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func loadPhoto(url: URL) {
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
