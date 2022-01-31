//
//  FotoAPI.swift
//  UI_app
//
//  Created by Вячеслав on 25.10.2021.
//

import Foundation
import Alamofire


class PhotoAPI {
    
    static var sharedId: String!

    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let version = "5.81"

    
    func getPhotos(completion: @escaping([PhotoStruct])->()) {
        
        let method = "/photos.getAll"

        let parameters: Parameters = [
            "owner_id": PhotoAPI.sharedId!,
            "extended": 1,
            "count": 100,
            "no_service_albums": 0,
            "access_token": token,
            "v": version
        ]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: { response in


        guard let data = response.data else { return }

        
        do {
            let photoJSON = try JSONDecoder().decode(PhotoJSON.self, from: data)
            let photos = photoJSON.response.items

            completion(photos)
        } catch {
            print(error)
        }
        })
        
    }
}
