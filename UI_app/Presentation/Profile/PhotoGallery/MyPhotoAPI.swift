//
//  MyPhotoAPI.swift
//  UI_app
//
//  Created by Вячеслав on 30.11.2021.
//

import Foundation
import Alamofire


class MyPhotoAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let id = MySession.shared.userId
    let version = "5.81"

    func myGetPhotos(completion: @escaping([MyPhotoStruct])->()) {
        
        let method = "/photos.getAll"
        let parameters: Parameters = [
            "owner_id": id,
            "extended": 1,
            "count": 100,
            "photo_sizes": 1,
            "no_service_albums": 0,
            "access_token": token,
            "v": version
        ]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: { response in


        guard let data = response.data else { return }

        
        do {
            let photoJSON = try JSONDecoder().decode(MyPhotoJSON.self, from: data)
            let photos = photoJSON.response.items

            completion(photos)
        } catch {
            print(error)
        }
        })
        
    }
}

