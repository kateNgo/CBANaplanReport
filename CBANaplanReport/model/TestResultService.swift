//
//  TestResultService.swift
//  CBANaplanReport
//
//  Created by phuong on 25/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation

class TestResultService {
    private var serviceHelper: ServiceHelper
    
    init(serviceHelper: ServiceHelper = ServiceHelperFactory.makeServiceHelper()) {
        self.serviceHelper = serviceHelper
    }
    
    func getTestResults(completion: @escaping (Result<[TestResult],ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.getTestResults.rawValue, param: nil) { result in
            switch result {
            case .success(let json):
                let testResults = TestResult.testResults(json: json)
                completion(.success(testResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getTestResults(studentId: String, completion: @escaping (Result<[TestResult],ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.getTestResults.rawValue, param: studentId) { result in
            switch result {
            case .success(let json):
                let testResults = TestResult.testResults(json: json)
                completion(.success(testResults))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getTestResults(forStudent studentId: String, byYear year:GradeYear, andBySubject subject: Subject, completion: @escaping (Result<TestResult,ServiceError>) -> Void) {
        serviceHelper.request(urlString: ServiceURLs.getTestResults.rawValue, param: studentId) { result in
            switch result {
            case .success(let json):
                let testResults = TestResult.testResults(json: json)
                var testResult : TestResult
                for ts in testResults {
                    if ts.gradeYear == year && ts.subject == subject {
                        testResult = ts
                        completion(.success(testResult))
                        return
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
