//
//  GroupsAPI.swift
//  UI_app
//
//  Created by Вячеслав on 21.10.2021.
//

import Foundation
import Alamofire



final class GroupsAPI  {
    
    let baseUrl = "https://api.vk.com/method"
    
    let token = MySession.shared.token
    let userId = MySession.shared.userId
    let version = "5.81"
    
    func getGroups(completion: @escaping([GroupModel])->()) {
        
        let method = "/groups.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "fields": "description",
            "count": 50,
            "access_token": token,
            "v": version,
        ]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: { response in
            guard let data = response.data else { return }
            do {
                let groupJSON = try JSONDecoder().decode(GroupJSON.self, from: data)
                let groups = groupJSON.response.items
                DispatchQueue.main.async {
                    completion(groups)
                }
            } catch {
                print(error)
            }
        })
    }
}
