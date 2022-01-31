//
//  GalleryGroupAPI.swift
//  UI_app
//
//  Created by Вячеслав on 18.01.2022.
//

import Foundation
import Alamofire


class GalleryGroupAPI {
    
    static var selectGroupId: String!

    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let version = "5.81"

    
    func getPhotosGroup(completion: @escaping([GroupPhotoStruct])->()) {
        
        let method = "/photos.getAll"

        let parameters: Parameters = [
            "owner_id": "-" + GalleryGroupAPI.selectGroupId,
            "extended": 1,
            "count": 100,
            "no_service_albums": 0,
            "access_token": token,
            "v": version
        ]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: { response in


        guard let data = response.data else { return }
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!\(response)")

        
        do {
            let photoJSON = try JSONDecoder().decode(PhotooGroupJSON.self, from: data)
            let photos = photoJSON.response.items

            completion(photos)
        } catch {
            print(error)
        }
        })
        
    }
}
