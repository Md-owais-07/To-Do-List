//
//  AppUiViewController.swift
//  To-Do List
//
//  Created by Owais on 22/06/24.
//

import UIKit

class AppUiViewController: UIViewController, UITextFieldDelegate {
    
    @objc func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func backToRootAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
