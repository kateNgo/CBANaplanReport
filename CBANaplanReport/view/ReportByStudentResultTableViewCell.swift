//
//  ReportByStudentResultTableViewCell.swift
//  CBANaplanReport
//
//  Created by phuong on 25/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class ReportByStudentResultTableViewCell: UITableViewCell {

    
    @IBOutlet var subjectCellLabel: UILabel!
    @IBOutlet var scoreCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(true, animated: animated)

        // Configure the view for the selected state
    }

}
