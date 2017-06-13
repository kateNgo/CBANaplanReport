//
//  ReportByStudentViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 24/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class ReportByStudentViewController: UIViewController {
    
    weak var activityIndicaView: UIActivityIndicatorView!
    fileprivate lazy var studentManager: StudentManager = StudentManager()
    var selectedStudent: Student?{
        didSet{
            if selectedStudent == nil{
                studentValue.setTitle("Select student", for: .normal)
            }
        }
    }
    var selectedGradeYear: GradeYear?{
        didSet{
            self.studentsByYear = self.getStudents(by: self.students, for:self.selectedGradeYear!)
            self.selectedStudent = nil
        }
    }
    var students: [Student] = []
    var studentsByYear: [Student] = []
    @IBOutlet var gradeYearValue: UIButton!
    @IBOutlet var studentValue: UIButton!
    @IBOutlet var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.dressForContinueButton()
        activityIndicaView = NaplanUIView.createActivityIndicator(inView: self.view)
        activityIndicaView.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        displaySelectedValues()
        loadStudents()
        addRightButtonItems(inController: self, withOptions: [NaplanOptions.logout])
    }

    private func showAlert(withMessage message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
        
    }
    private func displaySelectedValues() {
        if selectedGradeYear != nil  {
            self.gradeYearValue.setTitle(selectedGradeYear?.description, for: .normal)
        }
        if let student = selectedStudent {
            self.studentValue.setTitle(student.fullName, for: .normal)
        }
    }
    private func loadStudents () {
        studentManager.getStudents{ result in
            switch result {
            case .success(let students):
                self.students = students
                self.studentsByYear = students
                self.activityIndicaView.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            case .failure:
                print(" some thing wrong")
            }
        }
    }
    
    func getStudents(by students:[Student], for year: GradeYear) -> [Student]{
        var newList : [Student] = []
        for student in students {
            if student.gradeYear == year {
                newList.append(student)
            }
        }
        return newList
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? StudentListViewController {
            controller.delegate = self
            controller.students = studentsByYear
            controller.selectedStudent = selectedStudent
        }
        if let controller = segue.destination as? GradeYearTableViewController {
            controller.delegate = self
            controller.selectedGradeYear = selectedGradeYear
        }
        if let controller = segue.destination as? ReportByStudentResultViewController {
            controller.student = selectedStudent
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showReportByStudent" && selectedStudent == nil {
            NaplanUIView.showAlert(withMessage: "please select student", inViewController: self)
            return false
        }
        if identifier == "showStudentTable" && studentsByYear.count == 0 {
            NaplanUIView.showAlert(withMessage: "No student in \(self.selectedGradeYear!)", inViewController: self)
            return false
        }
        return true
    }
    
}


