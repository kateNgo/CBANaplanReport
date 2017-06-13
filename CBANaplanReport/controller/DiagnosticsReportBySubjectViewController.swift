//
//  DiagnosticsReportBySubjectViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 29/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit
import Charts

class DiagnosticsReportBySubjectViewController: DiagnosticsBaseViewController{
    
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    var testResults:  [TestResult] = []
    var students: [Student] = []
    var year : GradeYear?
    var subject: Subject?
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initData(){
        guard let theSubject = subject, let theYear = year else {
            return
        }
        yearLabel.text = theYear.description
        subjectLabel.text = "Subject: " + theSubject.description
    }
    
    override func setChart(){
        var dataSets: [BarChartDataSet] = []
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<students.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: testResults[i].score)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Score of \(self.subject!.description)" )
        chartDataSet.colors = ChartColorTemplates.colorful()
        dataSets.append(chartDataSet)
        let chartData = BarChartData( dataSets: dataSets)
        let barWidth = 0.5
        chartData.barWidth = barWidth
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: students.map{return $0.fullName})
        barChartView.xAxis.labelCount = testResults.count
        barChartView.xAxis.labelRotationAngle = CGFloat(90)
        barChartView.fitBars = true
        barChartView.data = chartData
        barChartView.setVisibleXRangeMaximum(10)
        calculateAverageScore()
    }
    
    private func calculateAverageScore(){
        var averageScore = 0.0
        for rs in testResults {
            averageScore += rs.score
        }
        averageScore = averageScore / Double(testResults.count)
        let ll = ChartLimitLine(limit: averageScore, label: String(format: "Average Of Year: %.1f", averageScore))
        barChartView.leftAxis.addLimitLine(ll)
    }
   
}
