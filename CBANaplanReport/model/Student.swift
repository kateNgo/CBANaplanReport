//
//  Student.swift
//  CBANaplanReport
//
//  Created by phuong on 24/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation

struct Student : CustomStringConvertible{
   
    private enum JSONKeys{
        static let studentId = "studentId"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let gradeYear = "gradeYear"
        static let  students = "students"
    }
   
    let studentId: String
    let firstName: String
    let lastName: String
    let gradeYear: GradeYear
    
    public var description: String { return firstName + " " + lastName + " " + gradeYear.description}
    var fullName : String {
        return firstName + " " + lastName
    }
    
    init(id: String, firstName: String, lastName: String, gradeYear:  GradeYear) {
        self.studentId = id
        self.firstName = firstName
        self.lastName = lastName
        self.gradeYear = gradeYear
    }
    // let gradeYear = json[JSONKeys.gradeYear] as? String
    
    init?(json: JSON){
        guard let studentId = json[JSONKeys.studentId] as? String,
        let firstName = json[JSONKeys.firstName] as? String,
        let lastName = json[JSONKeys.lastName] as? String,
        let gradeYear = json[JSONKeys.gradeYear] as? Int
           else {
                return nil
        }
        self.init(id: studentId, firstName: firstName, lastName: lastName, gradeYear: GradeYear.init(withInt: gradeYear))
    }
    
    static func studentList(json: JSON) -> [Student]{
        guard let studentArray = json[JSONKeys.students] as? [JSON] else {return [] }
        return studentArray.flatMap{return Student(json: $0)}
    }
}
