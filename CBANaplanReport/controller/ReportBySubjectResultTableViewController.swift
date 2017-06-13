//
//  ReportBySubjectResultTableViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 28/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit


class ReportBySubjectResultTableViewController: ReportResultTableViewController {
    
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    fileprivate lazy var testResultManager: TestResultManager = TestResultManager()
    fileprivate lazy var studentManager: StudentManager = StudentManager()
    var students: [Student] = []
    var year: GradeYear?
    var subject: Subject?
    var testResults:[TestResult] = []{
        didSet{
            tableView?.reloadData()
            tableView.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theYear = year , let theSubject = subject {
            self.loadTestResults(forYear: theYear, bySubject: theSubject)
            yearLabel.text = theYear.description
            subjectLabel.text = "Subject: " + theSubject.description
        }
    }

    private func loadStudents(byYear year:GradeYear, completion: @escaping (Result<[Student], ServiceError>) -> Void) {
        if let gradeYear = self.year {
            studentManager.getStudents(byYear: gradeYear){ result in
                switch result{
                case .success(let students):
                    completion(.success(students))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadTestResults(forYear year: GradeYear, bySubject subject: Subject) {
        self.subject = subject
        self.year = year
        self.loadStudents(byYear: year) { result in
            switch result{
            case .success(let students):
                let theStudents = students
                self.students = []
                self.testResults = []
                var counter: Int = 0
                for st in theStudents {
                    self.testResultManager.getTestResults(forStudent: st.studentId, byYear: year, andBySubject: subject) { result_testResult in
                        switch result_testResult{
                        case .success(let testResult):
                            self.students.append(st)
                            self.testResults.append(testResult)
                            counter += 1
                            if counter == theStudents.count {
                                self.activityIndicatorView.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                            }
                        case .failure:
                            print("failed at loadTestResults(forYear year: Int, bySubject subject: String)")
                            self.activityIndicatorView.stopAnimating()
                            NaplanUIView.showAlert(withMessage: "No test result for \(year) with subject \(subject)", inViewController: self)
                        }
                    }
                }
            case .failure:
                print("canot load studens by \(year.description) for \(subject.description)")
                self.activityIndicatorView.stopAnimating()
                NaplanUIView.showAlert(withMessage: "cannot load studens by \(year.description) for \(subject.description)", inViewController: self)
            }
        }
       
    }

    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return testResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeue = tableView.dequeueReusableCell(withIdentifier: "reportBySubjectCell", for: indexPath)
        let cell = dequeue as! ReportBySubjectResultTableViewCell
        cell.studentLabel.text = students[indexPath.row].fullName
        cell.scoreLabel.text = String(testResults[indexPath.row].score)
        return cell
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DiagnosticsReportBySubjectViewController, let theYear = year, let theSubject = subject {
            controller.students = students
            controller.testResults = testResults
            controller.year = theYear
            controller.subject = theSubject
        }
    }
}
