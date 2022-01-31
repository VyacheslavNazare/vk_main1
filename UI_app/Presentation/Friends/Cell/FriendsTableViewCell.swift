//
//  FriendsTableViewCell.swift
//  UI_app
//
//  Created by Вячеслав on 11.08.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    static let identifier = "FriendsTableViewCell"
    
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet private var labelCell: UILabel!
    

    func configure(friend: FriendsModel) {
        circleView.setImageLoad(friend.photo100)
        labelCell.text = friend.fullName

    }
}


