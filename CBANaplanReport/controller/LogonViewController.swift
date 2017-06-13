//
//  LogonViewController.swift
//  CBANaplanReport
//
//  Created by phuong on 18/5/17.
//  Copyright © 2017 ppben. All rights reserved.
//

import UIKit

class LogonViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var usernameTextField: UITextField!
    fileprivate lazy var naplanUserManager: NaplanUserManager = NaplanUserManager()
    fileprivate var naplanUsers: [NaplanUser]?
    override func viewDidLoad() {
        super.viewDidLoad()
        settupInterface()
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.errorLabel.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @IBAction func logonHandler(_ sender: UIButton) {
        guard let username =  usernameTextField.text , let password = passwordTextField.text else {
            return
        }
        naplanUserManager.logon(username: username, password: password ) { success in
            if success {
                self.loginDone()
            } else {
                self.errorLabel.text = "Wrong username or password. Try again!"
            }
        }
    }
    
    func loginDone()
    {
        self.errorLabel.text = ""
        self.passwordTextField.text = ""
        self.usernameTextField.text = ""
       self.performSegue(withIdentifier: "gotoReport", sender: self)
    }
    
    @IBAction func unwindToLogon(_ segue: UIStoryboardSegue) {
    }
    
    // MARK: - UITextFieldDelegate
    private enum status{
        static let hasFocus = UIColor.cyan
        static let lostFocus = UIColor.white
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = status.hasFocus
        textField.becomeFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = status.lostFocus
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func settupInterface(){
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        self.errorLabel.text = ""
        loginButton.dressForContinueButton()
    }
}
