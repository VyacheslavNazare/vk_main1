//
//  ProfileAPI.swift
//  UI_app
//
//  Created by Вячеслав on 27.11.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


final class ProfileAPI {
    

    
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let userId = MySession.shared.userId
    let version = "5.81"

    func getProfile(completion: @escaping([ProfileModel])->()) {

        let method = "/users.get"
        
        let parameters: Parameters = [
            "user_ids": userId,
            "fields": "photo_100,bdate",
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
            
            do {
                let items = try JSON(data)["response"].rawData()
                let profile = try JSONDecoder().decode([ProfileModel].self, from: items)
                completion(profile)

                
            } catch {
                debugPrint(error)
            }
            
            
        }
        
        
    }

    
}
