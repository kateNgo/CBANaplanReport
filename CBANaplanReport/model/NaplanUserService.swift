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
    func logon(withUsername username:String, andPassword password: String, completion: @escaping (Result<Bool, ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.login.rawValue, param: username) { result in
            switch result {
            case .success(let json):
                guard let ok = json["result"] as? Bool else {
                    completion(.failure(.general))
                    return
                }
                completion(.success(ok))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


