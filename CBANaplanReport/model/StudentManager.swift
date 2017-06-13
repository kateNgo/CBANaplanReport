//
//  StudentManager.swift
//  CBANaplanReport
//
//  Created by phuong on 24/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation

class StudentManager {
    var studentService : StudentService
    
    init(studentService: StudentService = StudentService()) {
        self.studentService = studentService
    }
    
    func getStudents(completion: @escaping (Result<[Student], ServiceError>) -> Void) {
        studentService.getStudents{ result in
            switch result {
            case .success(let students):
                completion(.success(students))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    func getStudents(byYear year: GradeYear, completion: @escaping (Result<[Student], ServiceError>) -> Void) {
        studentService.getStudents(byYear: year){ result in
            switch result {
            case .success(let students):
                completion(.success(students))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
