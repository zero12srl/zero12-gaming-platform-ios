//
//  LoginViewController.swift
//  zero12-gaming
//
//  Created by Michele Massaro on 13/06/2018.
//  Copyright © 2018 zero12. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomScrollSpace: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmailField()
        setupPasswordField()
        setupButton()
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        contentHeight.constant = safeAreaHeight
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            self?.showLoginElements()
        }
        
        // Keyboard notifications
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        contentHeight.constant = safeAreaHeight
    }
    
    private func setupEmailField() {
        emailView.layer.cornerRadius = 25
        emailView.alpha = 0
    }
    
    private func setupPasswordField() {
        passwordView.layer.cornerRadius = 25
        passwordView.alpha = 0
    }
    
    private func setupButton() {
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor(hex: 0xF35C22).cgColor
        loginButton.layer.cornerRadius = 30
        loginButton.alpha = 0
    }
    
    private func showLoginElements() {
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.emailView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.6, delay: 0.10, options: .curveEaseInOut, animations: { [weak self] in
            self?.passwordView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.6, delay: 0.20, options: .curveEaseInOut, animations: { [weak self] in
            self?.loginButton.alpha = 1
        }, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak self] in
            if let s = self {
                s.scrollView.scrollRectToVisible(CGRect(x: 0, y: s.scrollView.contentSize.height-1, width: 1, height: 1), animated: true)
            }
        }
    }
    
    // MARK: - Keyboard functions
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        if let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.35, animations: {
                self.bottomScrollSpace.constant = keyboardFrame.size.height
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.35, animations: {
            self.bottomScrollSpace.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailField {
            _ = passwordField.becomeFirstResponder()
        } else if textField === passwordField {
            textField.resignFirstResponder()
        }
        return false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}
