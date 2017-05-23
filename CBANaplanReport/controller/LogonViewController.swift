//
//  LogonViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 18/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class LogonViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    fileprivate lazy var naplanUserManager: NaplanUserManager = NaplanUserManager()
    fileprivate var naplanUsers: [NaplanUser]?
    
    //private var naplanService: NaplanService = NaplanService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naplanUserManager.getNaplanUsers{ [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let naplanUsers):
                this.naplanUsers = naplanUsers
            case .failure:
                print("Some thing wrong")
            }
            print("ssssss")
            
        }
    }

    
    @IBAction func logonHanlder(_ sender: Any) {

        if passwordTextField.text == "" || usernameTextField.text == "" {
            return
        }
        // do validation
        /*
        naplanService.logon(userName: usernameTF.text!, password: passwordTextField.text!) { success in
            if success {
                performSegue(withIdentifier: "dashboardSegue", sender: self)
            } else {
                // show some alert
                // UIAlertController
          
    }
        }
 */
    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if passwordTextField.text == "" || usernameTextField.text == "" {
                return false
        }
        //if naplanService.logon(userName: usernameTF.text!, password: passwordTextField.text!) {
        //    return true
        //}
        // display error logon
        return false
    }
    

    

}
