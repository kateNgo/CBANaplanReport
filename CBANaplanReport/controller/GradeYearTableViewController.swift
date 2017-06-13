//
//  GradeYearTableViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 26/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

protocol GradeYearListViewControllerDelegate: class {
    func sendSelectedGradeYearToPreviousVC(selectedGradeYear:GradeYear)
}

class GradeYearTableViewController: UITableViewController {

    weak var delegate: GradeYearListViewControllerDelegate?
    var selectedGradeYear: GradeYear?
    var gradeYears: [GradeYear] = GradeYear.allValues
    override func viewDidLoad() {
        super.viewDidLoad()
        makePositionForGradeYearPopover()
    }
    
    private func makePositionForGradeYearPopover() {
        let popoverBounds:CGRect = self.view.frame
        var newBounds = self.tableView.bounds
        newBounds.size.width = popoverBounds.size.width
        newBounds.size.height = popoverBounds.size.height/2
        self.tableView.bounds = newBounds
        tableView.sizeToFit()
        self.preferredContentSize = self.tableView.contentSize;
    }
      // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradeYears.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let dequece = tableView.dequeueReusableCell(withIdentifier: "gradeYearTableCell", for: indexPath)
        let cell = dequece as! GradeYearTableViewCell
        cell.gradeYearLabel?.text = self.gradeYears[indexPath.row].description
        cell.gradeYearLabel.textColor = NaplanUIView.colorForCell
        if let year = selectedGradeYear, let label =  cell.gradeYearLabel{
            if year.description == label.text {
                cell.gradeYearLabel.textColor = NaplanUIView.colorForSelectedCell
            } else {
                cell.gradeYearLabel.textColor = NaplanUIView.colorForCell
            }
        }
       cell.contentView.backgroundColor = NaplanUIView.bacgroundColorForTableView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedGradeYear = gradeYears[indexPath.row]
        delegate?.sendSelectedGradeYearToPreviousVC(selectedGradeYear: selectedGradeYear!)
        dismiss(animated: false, completion: nil)
        
    }
    
}
