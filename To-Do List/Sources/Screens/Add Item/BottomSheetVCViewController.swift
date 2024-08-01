//
//  BottomSheetVCViewController.swift
//  To-Do List
//
//  Created by Owais on 01/07/24.
//

import UIKit
import CoreData
import FirebaseAuth

class BottomSheetVCViewController: AppUiViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblAddToCart: UILabel!
    @IBOutlet weak var taskFiled: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var descView: UIView!
    @IBOutlet weak var statusView: UIView!
    
    var userData: [UserDataEntity] = []
    var dashboardVC: DashboardVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAdd.layer.cornerRadius = 8
        btnCancel.CornerRadiousBtn()
        taskView.CornerRadiousFinal(radius: 8, color: UIColor.systemGray4, borderWidth: 1.5)
        descView.CornerRadiousFinal(radius: 8, color: UIColor.systemGray4, borderWidth: 1.5)
        statusView.CornerRadiousFinal(radius: 8, color: UIColor.systemGray4, borderWidth: 1.5)
        self.HideKeyboardWhenTapAround()
        taskFiled.delegate = self
        descField.delegate = self
        statusField.delegate = self
        print("VIEWDIDLOAD() - BottomSheetVCViewController")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == taskFiled {
            descField.becomeFirstResponder()
        } else if textField == descField {
            statusField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func getUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        
        guard let todo = taskFiled.text, !todo.isEmpty else {
            self.toastView(toastMessage: "Please enter a task.", type: "error")
            return
        }
        guard let desc = descField.text, !desc.isEmpty else {
            self.toastView(toastMessage: "Please enter a description.", type: "error")
            return
        }
        guard let status = statusField.text, !status.isEmpty else {
            self.toastView(toastMessage: "Please enter a status.", type: "error")
            return
        }
        
        guard let userID = Auth.auth().currentUser?.uid else {
            self.toastView(toastMessage: "User not logged in.", type: "error")
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let userEntity = UserDataEntity(context: context)
        
        userEntity.userID = userID
        userEntity.isRemoved = false
        userEntity.todo = todo
        userEntity.descriptions = desc
        userEntity.status = status
        userEntity.date = Date()
        
        do {
            try context.save()
            dashboardVC?.updateLabels()
            NotificationCenter.default.post(name: .reloadFetchData, object: nil)
            NotificationCenter.default.post(name: .reloadCellHeight, object: nil)
            dismiss(animated: true)
            self.toastView(toastMessage: "Task added successfully.", type: "success")
            print("User data saved successfully")
        } catch {
            print("Error saving user data:", error.localizedDescription)
            self.toastView(toastMessage: "Error saving task. Please try again.", type: "error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DashboardVC_id" {
            if let displayVC = segue.destination as? DashboardVC {
                dashboardVC = displayVC
                print("DATA IS PASSING FROM ONE VC TO ANOTHER VC THROUGH SEGUE", displayVC)
            } else {
                print("DATA PASSING ERROR...")
            }
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        dismiss(animated: true) {
            // Action
        }
    }
    
}
