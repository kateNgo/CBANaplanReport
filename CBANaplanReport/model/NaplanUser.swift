//
//  User.swift
//  CBANaplanReport
//
//  Created by phuong on 19/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation

struct NaplanUser {
    
    private enum JSONKeys {
        static let username = "username"
        static let password = "password"
        static let naplanUsers = "naplanUsers"
    }
    
    let username: String
    let password: String
    
    init(username: String, password: String){
        self.username = username
        self.password = password
    }
    
    init?(json: JSON){
        guard let username = json[JSONKeys.username] as? String,
            let password = json[JSONKeys.password] as? String
            else {
                return nil
            }
        self.init(username: username, password:password)
    }
    static func naplanUserList(json: JSON) -> [NaplanUser]{
        guard let naplanUserArray = json[JSONKeys.naplanUsers] as? [JSON] else { return [] }
        return naplanUserArray.flatMap{return NaplanUser(json: $0)}
    }
   
}
