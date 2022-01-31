//
//  FriendsAPI.swift
//  UI_app
//
//  Created by Вячеслав on 19.10.2021.
//
//
import Foundation
import Alamofire
import SwiftyJSON


final class FriendsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let userId = MySession.shared.userId
    let version = "5.81"

    func getFriends(completion: @escaping([FriendsModel])->()) {

        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "hints",
            "fields": "photo_50, photo_100, bdate, city",
            "count": 100,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            guard let data = response.data else { return }
            
            do {
                let items = try JSON(data)["response"]["items"].rawData()
                let friends = try JSONDecoder().decode([FriendsModel].self, from: items)
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch {
                debugPrint(error)
            }
        }
    }
}



