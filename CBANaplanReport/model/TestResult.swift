//
//  TestResult.swift
//  CBANaplanReport
//
//  Created by phuong on 24/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation

struct  TestResult {

    private enum JSONKeys{
        static let studentId = "studentId"
        static let gradeYear = "year"
        static let subject = "subject"
        static let score = "score"
        static let  testResults = "testResults"
    }
    static func getSubjects() -> [String]{
        return [ Subject.reading.rawValue, Subject.writing.rawValue, Subject.spelling.rawValue, Subject.grammar.rawValue, Subject.numeracy.rawValue, Subject.dataMeasurement.rawValue, Subject.numberPatternAlgebra.rawValue ]
    }
    
    let studentId: String
    let gradeYear: GradeYear
    let subject: Subject
    let score: Double
    
    init(studentId: String, gradeYear: GradeYear, subject: Subject, score: Double){
        self.studentId = studentId
        self.gradeYear = gradeYear
        self.subject = subject
        self.score = score
    }
    init?(json: JSON){
        guard let studentId = json[JSONKeys.studentId] as? String,
        let gradeYear = json[JSONKeys.gradeYear] as? Int,
        let subject = json[JSONKeys.subject] as? String,
            let score = json[JSONKeys.score] as? Double else { return nil }
        let theGradeYear = GradeYear.init(withInt: gradeYear)
        let theSubject = Subject.init(withString: subject)
        self.init(studentId: studentId, gradeYear: theGradeYear, subject: theSubject,score: score)
        
    }
    static func testResults(json: JSON) -> [TestResult]{
        guard let results = json[JSONKeys.testResults] as? [JSON] else { return [] }
        return results.flatMap{ return TestResult(json: $0) }
    }
    static func groupByYear(testResults: [TestResult]) -> [[TestResult] ]{
        var result: [[TestResult] ] = []
        // sort by year
        let testResults = testResults.sorted(by: { $0.gradeYear.value > $1.gradeYear.value } )
        var year: GradeYear?
        var testResulEachYear: [TestResult] = []
        for r in testResults {
            if year != r.gradeYear {
              // begin another year of test result
                if testResulEachYear.count > 0 {
                    // sort by subject
                    testResulEachYear = testResulEachYear.sorted(by: {$0.subject.description < $1.subject.description})
                    result.append(testResulEachYear)
                    testResulEachYear = []
                }
                year = r.gradeYear
            }
            testResulEachYear.append(r)
        }
        testResulEachYear = testResulEachYear.sorted(by: {$0.subject.description < $1.subject.description})
        result.append(testResulEachYear)
        return result
    
    }
}
