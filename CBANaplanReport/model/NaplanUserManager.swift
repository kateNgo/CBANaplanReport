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
    func getNaplanUsers(completion: @escaping (Result<[NaplanUser], ServiceError>) -> Void) {
        naplanUserService.getNaplanUsers{ result in
            switch result {
            case .success(let naplanUsers):
                completion(.success(naplanUsers))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    func logon(userName:String , password:String, handler: (Bool) -> Void) {
        if userName == "phuong" && password == "phuong" {
            handler(true)
        }
        handler(false)
    }
   
}
