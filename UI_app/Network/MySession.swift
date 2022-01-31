//
//  Session.swift
//  UI_app
//
//  Created by Вячеслав on 19.10.2021.
//

import Foundation

final class MySession {

    static let shared = MySession()
    
    var token = ""
    var userId = ""
    
    private init(){}
}

