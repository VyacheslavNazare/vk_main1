//
//  NewsAPI.swift
//  UI_app
//
//  Created by Вячеслав on 06.11.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class NewsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    private let token = MySession.shared.token
    private let userId = MySession.shared.userId
    private let version = "5.81"
        
    func getNews(completion: @escaping([NewsModel]) -> Void) {
        let method = "/newsfeed.get"
        let parameters: Parameters = [
            "owner_id": userId,
            "filters": "post",
            "return_banned": 0,
            "count": 7,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseData(queue: DispatchQueue.global()) { response in
            guard let data = response.value else {return}
            print(data)
            
            guard var news = try? JSONDecoder().decode(ResponseNews.self, from: data).response.items else {return}
            guard let profiles = try? JSONDecoder().decode(ResponseNews.self, from: data).response.profiles else {return}
            guard let groups = try? JSONDecoder().decode(ResponseNews.self, from: data).response.groups else {return}
            
                        for i in 0..<news.count {
                            if news[i].sourceID < 0 {
                                let group = groups.first(where: { $0.id == -news[i].sourceID })
                                news[i].avatarURL = URL(string: group?.avatarURL ?? "")
                                news[i].creatorName = group?.name
                            } else {
                                let profile = profiles.first(where: { $0.id == news[i].sourceID })
                                news[i].avatarURL = URL(string: profile?.avatarURL ?? "")
                                news[i].creatorName = (profile?.firstName ?? "") + (profile?.lastName ?? "")
                            }
                        }
            DispatchQueue.main.async {
                completion(news)
            }
        }
    }
}
