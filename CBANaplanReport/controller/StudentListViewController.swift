//
//  StudentList.swift
//  CBANaplanReport
//
//  Created by phuong on 24/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

protocol StudentListViewControllerDelegate: class {
    func sendSelectedStudentToPreviousVC(selectedStudent:Student)
}

class StudentListViewController: UITableViewController{
    
    weak var delegate: StudentListViewControllerDelegate?
    var selectedStudent: Student?
    var students: [Student]?{
        didSet{
            tableView?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        makePositionForGradeYearPopover()
    }
    private func makePositionForGradeYearPopover() {
        let popoverBounds:CGRect = self.view.frame
        tableView.sizeToFit()
        var newBounds = self.tableView.bounds
        newBounds.size.width = popoverBounds.size.width
        newBounds.size.height = popoverBounds.size.height/2
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
        if let data = students {
            return data.count
        }
        return 0
    }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequece = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        let cell = dequece as! StudentTableViewCell
        if let data = students {
            self.setContent(cell: cell,value: data[indexPath.row].fullName)
            
        } else {
            self.setContent(cell: cell,value: " No Name")
        }
        cell.studentLabel.textColor = NaplanUIView.colorForCell
        if selectedStudent != nil && selectedStudent!.fullName == cell.studentLabel.text {
            // this cell is selected
            cell.studentLabel.textColor = NaplanUIView.colorForSelectedCell
        }else{
            cell.studentLabel.textColor = NaplanUIView.colorForCell
        }
        cell.contentView.backgroundColor = NaplanUIView.bacgroundColorForTableView
        return cell
    }
    
    private func setContent(cell: StudentTableViewCell, value: String) {
        cell.studentLabel?.text = value
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStudent = students?[indexPath.row]
        delegate?.sendSelectedStudentToPreviousVC(selectedStudent: (students?[indexPath.row])!)
        dismiss(animated: true, completion: nil)
    }
    
}


