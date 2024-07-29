//
//  SignupVC.swift
//  To-Do List
//
//  Created by Owais on 21/06/24.
//

import UIKit
import FirebaseAuth
import CoreData

class SignupVC: AppUiViewController {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var FullnameView: UIView!
    @IBOutlet weak var FullnameTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPassView: UIView!
    @IBOutlet weak var confirmPassTextfield: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FullnameView.TextFieldCornerRadious()
        emailView.TextFieldCornerRadious()
        passwordView.TextFieldCornerRadious()
        confirmPassView.TextFieldCornerRadious()
        btnLogin.CornerRadious()
        btnSignup.layer.cornerRadius = 8
        self.HideKeyboardWhenTapAround()
        FullnameTextField.delegate = self
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        confirmPassTextfield.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController {
            let count = navigationController.viewControllers.count
            print("Number of view controllers in the navigation stack - SignupVC: \(count)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == FullnameTextField {
            emailTextfield.becomeFirstResponder()
        } else if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        } else if textField == passwordTextfield {
            confirmPassTextfield.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func signupBtnAction(_ sender: Any) {
        guard let fullName = FullnameTextField.text, fullName != "" else {
            self.toastView(toastMessage: "Please enter your full name.", type: "error")
            return
        }
        guard let email = emailTextfield.text,  email != "" else {
            self.toastView(toastMessage: "Please enter your email address.", type: "error")
            return
        }
        guard let password = passwordTextfield.text, password != "" else {
            self.toastView(toastMessage: "Please enter your Password.", type: "error")
            return
        }
        guard password.count >= 6 else {
            self.toastView(toastMessage: "Please enter atleast 6 or more characters.", type: "error")
            return
        }
        guard let confirmPassword = confirmPassTextfield.text, confirmPassword != "" else {
            self.toastView(toastMessage: "Please enter Confirm Password.", type: "error")
            return
        }
        guard confirmPassword == password else {
            self.toastView(toastMessage: "Passwords do not match. Please ensure both passwords are identical.", type: "error")
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        print("USER REGISTER DATA STORING...", fullName)
        print("USER REGISTER DATA STORING...", email)
        
        do {
            try context.save()
            print("USER REGISTER DATA STORING...")
        } catch {
            print("USER REGISTER DATA STORING ERROR WITH:", error.localizedDescription)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                print("LOGIN ERROR WITH: \(err)")
            } else {
                self.toastView(toastMessage: "Registration Success!!", type: "success")
                UserData.shared.isLoggedIn = true
                UserData.shared.fullName = "\(fullName)"
                UserData.shared.emailAddress = email
                let dashboardVC = AppController.shared.dashboardVC
                let navigationController = UINavigationController(rootViewController: dashboardVC)
                navigationController.navigationItem.hidesBackButton = true
                navigationController.isNavigationBarHidden = true
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }
            }
        }
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
