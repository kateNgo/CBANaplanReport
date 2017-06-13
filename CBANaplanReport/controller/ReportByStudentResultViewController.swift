//
//  ReportByStudentResultViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 25/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class ReportByStudentResultViewController: ReportResultTableViewController {
    
    @IBOutlet var studentHeaderLabel: UILabel!
    @IBOutlet var yearHeaderLabel: UILabel!
    fileprivate lazy var testResultManager: TestResultManager = TestResultManager()
    var student:Student?{
        didSet{
            if let st = student {
                studentHeaderLabel?.text = "Student: \(st.fullName)"
                yearHeaderLabel?.text = "Year: \(st.gradeYear.value)"
            }
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTestResults(forStudent: student!)
    }
    
    var resultInYear: [TestResult] = []
    var testResults: [TestResult]?{
        didSet{
            for tr in self.testResults! {
                if tr.gradeYear == student?.gradeYear{
                    self.resultInYear.append(tr)
                }
            }
            resultInYear = resultInYear.sorted(by: {$0.subject.description < $1.subject.description})
            tableView?.reloadData()
            tableView.layoutIfNeeded()
        }
    }
    
    func loadTestResults(forStudent student: Student) {
        testResultManager.getTestResults(studentId: student.studentId){ result in
            switch result{
            case .success(let results):
                self.student = student
                self.testResults = results.sorted(by: {$0.subject.description < $1.subject.description})
                self.activityIndicatorView.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            case .failure:
                print("Canot load Test reuslt for student: \(student.fullName)")
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return resultInYear.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequece = tableView.dequeueReusableCell(withIdentifier: "ReportByStudentResult", for: indexPath)
        let cell = dequece as! ReportByStudentResultTableViewCell
        cell.subjectCellLabel?.text = resultInYear[indexPath.row].subject.description
        cell.scoreCellLabel?.text = String(format: " %.1f", resultInYear[indexPath.row].score)
        cell.backgroundColor = NaplanUIView.bacgroundColorForCellInTable
        cell.contentView.backgroundColor = NaplanUIView.bacgroundColorForCellInTable
        cell.scoreCellLabel.backgroundColor = NaplanUIView.bacgroundColorForCellInTable
        cell.subjectCellLabel.backgroundColor = NaplanUIView.bacgroundColorForCellInTable
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DiagnosticsByStudentViewController {
            controller.student = student
            controller.studentNaplanTestResult = testResults
        }
    }

}
