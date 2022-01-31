//
//  ProfileSelectFriends.swift
//  UI_app
//
//  Created by Вячеслав on 13.01.2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class ProfileSelectFriends {
    

    
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let userId = MySession.shared.userId
    let version = "5.81"

    func getProfileSelectFriends(completion: @escaping([ProfileSelectFriendsModel])->()) {

        let method = "/users.get"
        
        let parameters: Parameters = [
            "user_ids": PhotoAPI.sharedId!,
            "fields": "photo_100, bdate, sex",
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
//            debugPrint("!!!!!!!!!!!!!!!!\(response.data?.prettyJSON)")
            
            do {
                let items = try JSON(data)["response"].rawData()
                let profile = try JSONDecoder().decode([ProfileSelectFriendsModel].self, from: items)
                completion(profile)
                print("Profile!!!!!1\(response)")

                
            } catch {
                debugPrint(error)
            }
            
            
        }
        
        
    }

    
}

