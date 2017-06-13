//
//  NaplanUIView.swift
//  CBANaplanReport
//
//  Created by phuong on 30/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class NaplanUIView: UIView {

    static let bacgroundColorForTableView = UIColor.white
    static let bacgroundColorForCellInTable = UIColor.white
    static let colorForSelectedCell = UIColor.blue
    static let colorForCell = UIColor.darkGray
    
    static func createActivityIndicator(inView view: UIView) -> UIActivityIndicatorView{
        let indicator : UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(indicator)
        return indicator
    }
    
    public static func showAlert(withMessage message:String, inViewController controller:UIViewController){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        controller.present(alert, animated: true, completion: nil)
        
    }
    
}
// MARK: - ReportByStudentViewControllerDelegate
extension ReportBySubjectViewController: GradeYearListViewControllerDelegate, SubjectListViewControllerDelegate {
    func sendSelectedGradeYearToPreviousVC(selectedGradeYear:GradeYear){
        self.selectedGradeYear = selectedGradeYear
        self.gradeYearValue.setTitle(selectedGradeYear.description, for: .normal)
        
    }
    func sendSelectedSubjectToPreviousVC(selectedSubject:Subject){
        self.selectedSubject = selectedSubject
        self.subjectValue.setTitle(selectedSubject.description, for: .normal)
    }
}
// MARK: - ReportByStudentViewControllerDelegate
extension ReportByStudentViewController: StudentListViewControllerDelegate,GradeYearListViewControllerDelegate {
    func sendSelectedStudentToPreviousVC(selectedStudent:Student){
        self.selectedStudent = selectedStudent
        self.studentValue.setTitle(selectedStudent.fullName, for: UIControlState.normal)
    }
    func sendSelectedGradeYearToPreviousVC(selectedGradeYear:GradeYear){
        self.selectedGradeYear = selectedGradeYear
        self.gradeYearValue.setTitle(selectedGradeYear.description, for: UIControlState.normal)
    }
}
// MARK: - UIButton


extension UIButton {
    func dressForDiagnosticsButton(){
        self.layer.cornerRadius = 7;
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.white.cgColor
    }
    func dressForContinueButton(){
        self.layer.cornerRadius = 7;
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.white.cgColor
            //UIColor.init(red: 255, green: 255, blue: 0, alpha: 1).cgColor
    }
}



