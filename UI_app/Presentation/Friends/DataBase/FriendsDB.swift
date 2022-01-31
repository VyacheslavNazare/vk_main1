//
//  FriendsDB.swift
//  UI_app
//
//  Created by Вячеслав on 13.11.2021.
//

import Foundation
import RealmSwift

final class FriendsDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 25)
    }
    
    func save(_ items: [FriendsModel])  {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
    }
    func load() -> Results<FriendsModel> {
        let realm = try! Realm()
        let friends: Results<FriendsModel> = realm.objects(FriendsModel.self)
        return friends
    }
    func delete(_ item: [FriendsModel]) {
        let realm = try! Realm()
        try! realm.write{
            realm.delete(item)
        }
    }
    
   
}
