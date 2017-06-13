//
//  NaplanReportViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 4/6/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class NaplanReportViewController: UIViewController {
    
}

enum NaplanOptions{
    case logout
    case saveChart
}

extension UIViewController {
   
    func addRightButtonItems(inController controller: UIViewController,withOptions options: [NaplanOptions]){
        var items: [UIBarButtonItem] = []
        for option in options {
            switch option {
            case .logout:
                items.append(addLogoutButton(controller))
            case .saveChart:
                items.append(addSaveChartButton(controller))
            }
        }
        navigationItem.rightBarButtonItems = items
    }
    
    func addLogoutButton(_ target: UIViewController) -> UIBarButtonItem{
        let logoutButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_logout"), style: .done, target: target, action: #selector(UIViewController.doLogout))
        
        self.navigationItem.rightBarButtonItem = logoutButtonItem
        return logoutButtonItem
    }
    func addSaveChartButton(_ target: UIViewController) -> UIBarButtonItem{
        let saveChartButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "ic_save"), style: .plain, target: target,
                                                       action: #selector(DiagnosticsBaseViewController.saveChart))
        return saveChartButtonItem
    }
    
    func doLogout(){
        self.performSegue(withIdentifier: "unwindLogon", sender: self)
    }
}
