//
//  NaplanService.swift
//  CBANaplanReport
//
//  Created by phuong on 19/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class NaplanUserService {
    private var serviceHelper: ServiceHelper
    
    init(serviceHelper: ServiceHelper = ServiceHelperFactory.makeServiceHelper()){
        self.serviceHelper = serviceHelper
    }
    func getNaplanUsers(completion: @escaping (Result<[NaplanUser], ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.getUsers.rawValue, param: nil) { result in
            switch result {
            case .success(let json):
                let naplanUsers = NaplanUser.naplanUserList(json: json)
                completion(.success(naplanUsers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    /*
    func logon(naplanUser: NaplanUser, completion: (Bool) -> Void ){
        serviceHelper.request(urlString: ServiceURLs.getUsers.rawValue, param: nil) { result in
            switch result {
            case .success(let json):
                let naplanUsers = NaplanUser.naplanUserList(json: json)
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
 */
 
    
    
    
    

}
