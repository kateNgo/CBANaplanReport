//
//  DiagnosticsByStudentViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 27/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit
import Charts

class DiagnosticsByStudentViewController: DiagnosticsBaseViewController{
    
    private func colorByYear(year: GradeYear) -> UIColor{
        switch year{
        case .year5:
            return UIColor.green
        case .year7:
            return UIColor.red
        default:
            return UIColor.blue
        }
    }
    var studentNaplanTestResult:  [TestResult]?
    var student: Student?
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var studentLabel: UILabel!
    let subjectStrings = Subject.allDescriptions
    var scoresList: [[Double]] = []
    var years: [GradeYear] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initData(){
        if let results = studentNaplanTestResult {
            let rs = TestResult.groupByYear(testResults: results) // rs is array of resultTest array by year
            for rsByYear in rs {
                var scores: [Double] = []
                years.append(rsByYear[0].gradeYear)
                for ts in rsByYear {
                    scores.append(ts.score)
                }
                scoresList.append(scores)
            }
        }
        if let theStudent = student {
            studentLabel.text = "Student: " + theStudent.fullName
            yearLabel.text = "Year: \(theStudent.gradeYear.value)"
        }
    }
    override func setChart(){
        var dataSets: [BarChartDataSet] = []
        for i in 0..<years.count {
            var scores = scoresList[i]
            var dataEntries: [BarChartDataEntry] = []
            for i in 0..<self.subjectStrings.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: scores[i])
                dataEntries.append(dataEntry)
            }
            let chartDataSet = BarChartDataSet(values: dataEntries, label: years[i].description )
            
            chartDataSet.colors = [self.colorByYear(year: years[i])]
            dataSets.append(chartDataSet)
       }
        let chartData = BarChartData( dataSets: dataSets)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: subjectStrings)
        barChartView.xAxis.labelCount = subjectStrings.count
        if self.years.count == 1 {
            dressYear5(forChartData: chartData)
        }else {
            dressYearSevenAndNine(forChartData: chartData)
        }
        barChartView.fitBars = true
        barChartView.data = chartData
        barChartView.setVisibleXRangeMaximum(10)
        barChartView.xAxis.labelRotationAngle = CGFloat(90)
    }
    private func dressYear5(forChartData chartData: BarChartData){
        let barWidth = 0.2
        chartData.barWidth = barWidth
    }
    private func dressYearSevenAndNine(forChartData chartData: BarChartData ){
        let barSpace = 0.03
        let groupCount = subjectStrings.count + 1
        let startX = 0
        let barWidth = 0.2
        barChartView.xAxis.axisMinimum = Double(startX)
        let xaxis = barChartView.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.centerAxisLabelsEnabled = true
        xaxis.granularityEnabled = true
        xaxis.granularity = 1
        let groupSpace = calcGroupSpace(withBarWidth: barWidth, andBarSpace: barSpace, andNumberOfGroups: years.count)
        chartData.barWidth = barWidth
        let gg =  chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.xAxis.axisMaximum = Double(startX) + gg * Double(groupCount)
        chartData.groupBars(fromX: Double(startX), groupSpace: groupSpace, barSpace: barSpace)
    }
    func calcGroupSpace(withBarWidth barWidth: Double, andBarSpace barSpace: Double, andNumberOfGroups groups: Int)->Double{
        let groupSpace = 1 - (barWidth + barSpace) * Double(groups)
        return groupSpace
    }
    
}


