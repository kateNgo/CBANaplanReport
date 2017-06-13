//
//  TestResult.swift
//  CBANaplanReport
//
//  Created by phuong on 25/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation

class TestResultManager {
    var service : TestResultService
    init(service: TestResultService = TestResultService()) {
        self.service = service
    }
    
    func getTestResults( completion: @escaping (Result<[TestResult], ServiceError>) -> Void) {
        service.getTestResults{ result in
            switch result {
            case .success(let testResults):
                completion(.success(testResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getTestResults(studentId: String, completion: @escaping (Result<[TestResult], ServiceError>) -> Void) {
        service.getTestResults(studentId: studentId){ result in
            switch result {
            case .success(let testResults):
                completion(.success(testResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getTestResults(forStudent studentId: String, byYear year:GradeYear, andBySubject subject: Subject, completion: @escaping (Result<TestResult, ServiceError>) -> Void) {
        service.getTestResults(forStudent: studentId, byYear: year, andBySubject: subject) { result in
            switch result {
            case .success(let testResult):
                completion(.success(testResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    /*
    func getTestResults( forStudents students: [Student], byYear year:Int, andBySubject subject: String, completion: @escaping (Result<[TestResult], ServiceError>) -> Void) {
        service.getTestResults(forStudents: students, byYear: year, andBySubject: subject) { result in
            switch result {
            case .success(let testResults):
                completion(.success(testResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
   
    */
}
