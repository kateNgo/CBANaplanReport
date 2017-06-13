//
//  NaplanUserManager.swift
//  CBANaplanReport
//
//  Created by phuong on 23/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation

class NaplanUserManager {
    var naplanUserService : NaplanUserService
    
    init(naplanUserService: NaplanUserService = NaplanUserService()) {
        self.naplanUserService = naplanUserService
    }
    func logon(username:String, password:String, handler: @escaping (Bool) -> Void) {
        naplanUserService.logon(withUsername: username, andPassword: password){ result in
            switch result {
            case .success(let result):
                handler(result)
            case .failure:
                handler(false)
            }
        }
    }
}
