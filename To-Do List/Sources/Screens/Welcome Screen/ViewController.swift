//
//  ViewController.swift
//  To-Do List
//
//  Created by Owais on 20/06/24.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        ButtonDesign(btnSignUp)
        btnSignIn.layer.cornerRadius = 10
        btnSignIn.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
        btnSignUp.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnSignIn.transform = .identity
        btnSignUp.transform = .identity
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController {
            let count = navigationController.viewControllers.count
            print("Number of view controllers in the navigation stack - ViewController: \(count)")
        }
    }
    
    @objc func animateButton() {
        animateButtonPress(button: btnSignIn)
        animateButtonPress(button: btnSignUp)
    }
    
    func animateButtonPress(button: UIButton) {
        UIView.animate(withDuration: 1.0) {
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        self.navigationController?.pushViewController(AppController.shared.loginVC, animated: true)
    }
    
    @IBAction func btnSignUpAction(_ sender: Any) {
        self.navigationController?.pushViewController(AppController.shared.signUpVC, animated: true)
    }
    
}

extension ViewController {
    func ButtonDesign(_ btn: UIButton)
    {
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = #colorLiteral(red: 0, green: 0.5695490241, blue: 0.8254689574, alpha: 1)
        btn.layer.borderWidth = 2
    }
    
}
