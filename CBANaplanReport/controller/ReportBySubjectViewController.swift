//
//  ReportByClassAndSubjectViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 28/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class ReportBySubjectViewController: UIViewController{

    @IBOutlet var gradeYearValue: UIButton!
    @IBOutlet var subjectValue: UIButton!
    @IBOutlet var continueButton: UIButton!
    var selectedGradeYear: GradeYear?
    var selectedSubject: Subject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.dressForContinueButton()
        displaySelectedValues()
        addRightButtonItems(inController: self, withOptions: [NaplanOptions.logout])
    }

    private func displaySelectedValues() {
        if let year = selectedGradeYear {
            self.gradeYearValue.setTitle(year.description, for: UIControlState.normal)
        }
        if let sub = selectedSubject  {
            self.subjectValue.setTitle(sub.description, for: UIControlState.normal)
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GradeYearTableViewController {
            controller.delegate = self
            controller.selectedGradeYear = selectedGradeYear
        } else if let controller = segue.destination as? SubjectTableViewController {
            controller.delegate = self
            controller.selectedSubject = selectedSubject
        } else if let controller = segue.destination as? ReportBySubjectResultTableViewController {
            controller.year = selectedGradeYear
            controller.subject = selectedSubject
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if  identifier == "showReportBySubjectResult" {
            guard let _ = selectedSubject, let _ = selectedGradeYear else {
                NaplanUIView.showAlert(withMessage: "Please select Year and Subject.", inViewController: self)
                return false
            }
            return true
        }
        return true
    }
}
