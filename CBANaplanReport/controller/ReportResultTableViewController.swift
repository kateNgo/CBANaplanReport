//
//  ReportResultTableViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 8/6/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class ReportResultTableViewController: UITableViewController {

    weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var diagnosticsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        diagnosticsButton.dressForDiagnosticsButton()
        addRightButtonItems(inController: self, withOptions: [NaplanOptions.logout])
        activityIndicatorView = NaplanUIView.createActivityIndicator(inView: self.tableView)
        activityIndicatorView.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
}
