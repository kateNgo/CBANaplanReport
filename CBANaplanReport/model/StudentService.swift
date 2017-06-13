//
//  StudentService.swift
//  CBANaplanReport
//
//  Created by phuong on 24/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation

class StudentService {
    private var serviceHelper: ServiceHelper
    
    init(serviceHelper: ServiceHelper = ServiceHelperFactory.makeServiceHelper()) {
        self.serviceHelper = serviceHelper
    }
    
    func getStudents(completion: @escaping (Result<[Student],ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.getStudents.rawValue, param: nil) { result in
            switch result {
            case .success(let json):
                let students = Student.studentList(json: json)
                completion(.success(students))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getStudents(byYear year: GradeYear, completion: @escaping (Result<[Student],ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.getStudents.rawValue, param: nil) { result in
            switch result {
            case .success(let json):
                let students = Student.studentList(json: json)
                var results :[Student] = []
                for st in students {
                    if st.gradeYear == year {
                        results.append(st)
                    }
                }
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
