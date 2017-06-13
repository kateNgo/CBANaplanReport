//
//  ServiceReport.swift
//  CBANaplanReport
//
//  Created by phuong on 25/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import Foundation


enum GradeYear: Int {
    case year5
    case year7
    case year9
    init(withInt number:Int){
        switch number {
        case 5:
            self = .year5
        case 7:
            self = .year7
        default:
            self = .year9
        }
    }
    var value: Int{
        switch self {
        case .year5:
            return 5
        case .year7:
            return 7
        default:
            return 9
        }
    }
    var description: String{
        switch self {
        case .year5:
            return "Year 5"
        case .year7:
            return "Year 7"
        default:
            return "Year 9"
        }
    }
    static var allValues: [GradeYear] =
             [ .year5, .year7, .year9]
    static var allDescriptionValues: [String] { return allValues.map { return $0.description } }
}
        

enum Subject: String {
    case reading
    case writing = "Writing"
    case spelling = "Spelling"
    case grammar
    case numeracy
    case dataMeasurement
    case numberPatternAlgebra
    init(withString string: String){
        switch string {
        case "Reading":
            self = .reading
        case "Writing":
            self = .writing
        case "Spelling":
            self = .spelling
        case "Grammar & Punctuation":
            self = .grammar
        case "Numeracy":
            self = .numeracy
        case "Data, Measurement, Space & Geometry":
            self = .dataMeasurement
        default:
            self = .numberPatternAlgebra
        }
    }
    
    var description: String  {
        switch self {
        case .reading:
            return  "Reading"
        case .writing:
            return "Writing"
        case .spelling:
            return "Spelling"
        case .grammar:
            return "Grammar & Punctuation"
        case .numeracy:
            return "Numeracy"
        case .dataMeasurement:
            return "Data, Measurement, Space & Geometry"
        default:
            return "Number, Patterns & Algebra"
        }
    }
    
    static var allValues: [Subject]  {
        let subjects: [Subject] = [.reading, .writing, .spelling, .grammar, .numeracy, .dataMeasurement, .numberPatternAlgebra ]
        return subjects.sorted(by: {$0.description < $1.description})
    }
    static var allDescriptions: [String]  {
        return allValues.map{ $0.description}
    }
    
}
