//
//  EditProfileVC.swift
//  To-Do List
//
//  Created by Owais on 27/06/24.
//

import UIKit

class EditProfileVC: AppUiViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblEdit: UILabel!
    @IBOutlet weak var editUsernameView: UIView!
    @IBOutlet weak var editUserTextfield: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var leftTitle = "OK"
    var rightTitle = "Cancel"
    var leftBtnClouser: (() -> ())!
    var rightBtnClouser: (() -> ())!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView.alpha = 0
        self.contentView.alpha = 0
        contentView.CornerRadiousFinal(radius: 6, color: nil, borderWidth: nil, masksBounds: true)
        editUsernameView.CornerRadiousFinal(radius: 6, color: .systemGray, borderWidth: 1, masksBounds: true)
        emailView.CornerRadiousFinal(radius: 6, color: .systemGray, borderWidth: 1, masksBounds: true)
        btnOk.CornerRadiousFinal(radius: 8, color: nil, borderWidth: nil, masksBounds: true)
        btnCancel.CornerRadiousBtn()
        self.HideKeyboardWhenTapAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editUserTextfield.text = (UserData.shared.isLoggedIn ? UserData.shared.fullName : "")
        emailTextfield.text = (UserData.shared.isLoggedIn ? UserData.shared.emailAddress : "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
           self.backgroundView.alpha = 0.4
           self.contentView.alpha = 1.0
           self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func okBtnAction(_ sender: Any) {
        dismiss {
            self.leftBtnClouser()
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
    }
    
    func dismiss(completion:(()->())? = nil) {
       UIView.animate(withDuration: 0.3, animations: {
          self.backgroundView.alpha = 0
          self.contentView.alpha = 0
          self.view.layoutIfNeeded()
       }) { (complete) in
          if complete {
             self.dismiss(animated: false) {
                DispatchQueue.main.async {
                   completion?()
                }
             }
          }
       }
    }
}
