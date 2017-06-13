//
//  SubjectTableViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 28/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

protocol SubjectListViewControllerDelegate: class {
    func sendSelectedSubjectToPreviousVC(selectedSubject:Subject)
}

class SubjectTableViewController: UITableViewController {
    var selectedSubject: Subject?
    let subjects:[Subject] = Subject.allValues
    weak var delegate: SubjectListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makePositionForGradeYearPopover()
    }
    private func makePositionForGradeYearPopover() {
        let popoverBounds:CGRect = self.view.frame
        tableView.sizeToFit()
        var newBounds = self.tableView.bounds
        newBounds.size.width = popoverBounds.size.width
        newBounds.size.height = 700
        self.tableView.bounds = newBounds;
        self.preferredContentSize = self.tableView.contentSize;
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjects.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequece = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)
        let cell = dequece as! SubjectTableViewCell
        if let label =  cell.subjectCellLabel {
            label.text = subjects[indexPath.row].description
            if let subject = selectedSubject{
                if label.text == subject.description {
                    label.textColor = NaplanUIView.colorForSelectedCell
                } else {
                    label.textColor = NaplanUIView.colorForCell
                }
            }
        }
        cell.backgroundColor = NaplanUIView.bacgroundColorForTableView
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SubjectTableViewCell
        {
            if let  label = cell.subjectCellLabel {
                selectedSubject =  Subject.init(withString: label.text!)
                delegate?.sendSelectedSubjectToPreviousVC(selectedSubject: selectedSubject! )
            }
        }
        dismiss(animated: false, completion: nil)
    }
  
}
