//
//  LoginVC.swift
//  To-Do List
//
//  Created by Owais on 21/06/24.
//

import UIKit
import FirebaseAuth

class LoginVC: AppUiViewController {
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var btnForgetPassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailView.TextFieldCornerRadious()
        passwordView.TextFieldCornerRadious()
        btnSignup.CornerRadious()
        btnLogin.layer.cornerRadius = 8
        btnSignup.tintColor = #colorLiteral(red: 0.03243464977, green: 0.6370635629, blue: 0.9011487961, alpha: 1)
        btnSignup.addTarget(self, action: #selector(BackView), for: .touchUpInside)
        self.HideKeyboardWhenTapAround()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController {
            let count = navigationController.viewControllers.count
            print("Number of view controllers in the navigation stack - LoginVC: \(count)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        
        guard let email = emailTextField.text,  email != "" else {
            self.toastView(toastMessage: "Please enter your email address.", type: "error")
            return
        }
        guard let password = passwordTextField.text, password != "" else {
            self.toastView(toastMessage: "Please enter your Password.", type: "error")
            return
        }
        guard password.count >= 6 else {
            self.toastView(toastMessage: "Please enter atleast 6 or more characters.", type: "error")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err = error {
                print("LOGIN ERROR WITH: \(err)")
            } else {
                self.toastView(toastMessage: "Login Success!!", type: "success")
                UserData.shared.isLoggedIn = true
                UserData.shared.emailAddress = email
                print("LOGIN USER MAIL ADDRESS: ", email)
                
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
    
    @objc func BackView(_ sender: UIButton) {
        self.navigationController?.pushViewController(AppController.shared.signUpVC, animated: true)
    }
    
}
