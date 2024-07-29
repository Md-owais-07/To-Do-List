//
//  ProfileVC.swift
//  To-Do List
//
//  Created by Owais on 26/06/24.
//

import UIKit
import FirebaseAuth

class ProfileVC: AppUiViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var imgAboutView: UIView!
    @IBOutlet weak var imgLogoutVieew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEditProfile.CornerRadiousFinal(radius: 8, color: nil, borderWidth: nil, masksBounds: nil)
        imgView.CornerRadiousFinal(radius: 8, color: nil, borderWidth: nil, masksBounds: nil)
        imgAboutView.CornerRadiousFinal(radius: 8, color: nil, borderWidth: nil, masksBounds: nil)
        imgLogoutVieew.CornerRadiousFinal(radius: 8, color: nil, borderWidth: nil, masksBounds: nil)
        btnLogOut.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblName.text = (UserData.shared.isLoggedIn ? "\(UserData.shared.fullName)" : "")
        lblEmailAddress.text = (UserData.shared.isLoggedIn ? "\(UserData.shared.emailAddress)" : "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController {
            let count = navigationController.viewControllers.count
            print("Number of view controllers in the navigation stack - ProfileVC: \(count)")
        }
    }
    
    @IBAction func act(_ sender: Any) {
        navigationController?.pushViewController(AppController.shared.gotoVC, animated: true)
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        print("BUTTON")
    }
    
    @IBAction func editBtnAction(_ sender: Any) {
        showAlert1 {
            print("RIGHT BUTTON TAPPED...(PROFILE VC)")
        } leftAction: {
            print("LEFT BUTTON TAPPED...(PROFILE VC)")
        }
        
    }
    
    @objc func logOut() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you, want to log out?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
                UserData.shared.isLoggedIn = false
                let loginVC = AppController.shared.startVC
                let navigationController = UINavigationController(rootViewController: loginVC)
                navigationController.navigationItem.hidesBackButton = true
                navigationController.isNavigationBarHidden = true
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }
                print("LOG OUT SUCCESS TAPPED...")
            } catch {
                print("LOG OUT ERROR WITH: \(error.localizedDescription)")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert1(leftactionTitle: String = "OK", rightactionTitle: String = "Cancel", rightAction: @escaping ()->(), leftAction: @escaping ()->()) {
        DispatchQueue.main.async {
            let popUpVC = AppController.shared.editProfileVC
            popUpVC.rightBtnClouser = rightAction
            popUpVC.leftBtnClouser = leftAction
            popUpVC.rightTitle = rightactionTitle
            popUpVC.leftTitle = leftactionTitle
            popUpVC.modalTransitionStyle = .crossDissolve
            popUpVC.modalPresentationStyle = .overCurrentContext
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window.rootViewController?.present(popUpVC, animated: false, completion: nil)
            } else {
                print("No suitable UIWindowScene or window found.")
            }
        }
    }
}
