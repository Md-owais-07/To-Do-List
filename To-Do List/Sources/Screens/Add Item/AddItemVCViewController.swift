//
//  AddItemVCViewController.swift
//  To-Do List
//
//  Created by Owais on 23/06/24.
//

import UIKit
import CoreData

class AddItemVCViewController: AppUiViewController, UITextViewDelegate {
    @IBOutlet weak var CustomBGView: UIView!
    @IBOutlet weak var ContentBGView: UIView!
    @IBOutlet weak var todoView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var taskField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var dateField: UITextView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var leftTitle = "OK"
    var rightTitle = "Cancel"
    var leftBtnClouser: (() -> ())!
    var rightBtnClouser: (() -> ())!
    
    var taskTitle: String?
    var taskDesc: String?
    var taskStatus: String?
    var task: UserDataEntity?
    var context: NSManagedObjectContext?
    var onSave: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ContentBGView.alpha = 0
        self.CustomBGView.alpha = 0
        todoView.CornerRadiousFinal(radius: 6, color: UIColor.systemGray, borderWidth: 1)
        dateView.CornerRadiousFinal(radius: 6, color: UIColor.systemGray, borderWidth: 1)
        timeView.CornerRadiousFinal(radius: 6, color: UIColor.systemGray, borderWidth: 1)
        btnOk.layer.cornerRadius = 8
        ContentBGView.layer.cornerRadius = 8
        CustomBGView.layer.cornerRadius = 6
        btnCancel.CornerRadiousBtn()
        
        taskField.text = taskTitle
        dateField.text = taskDesc
        timeField.text = taskStatus
        
        taskField.delegate = self
        dateField.delegate = self
        timeField.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
           self.CustomBGView.alpha = 0.4
           self.ContentBGView.alpha = 1.0
           self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == taskField {
            dateField.becomeFirstResponder()
        } else if textField == dateField {
            timeField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func leftBtnAction(_ sender: Any) {
        leftBtnClouser = {
            guard let context = self.context else {
                print("Context is nil")
                return
            }
            guard let task = self.task else {
                print("Task is nil")
                return
            }
            
            task.todo = self.taskField.text
            task.descriptions = self.dateField.text
            task.status = self.timeField.text
            
            print("Updating Task with:")
            print("Title: \(task.todo ?? "No Title")")
            print("Description: \(task.descriptions ?? "No Description")")
            print("Status: \(task.status ?? "No Status")")
            
            do {
                try context.save()
                NotificationCenter.default.post(name: .updateRefresh, object: nil)
                print("Task successfully updated.")
            } catch {
                print("Failed to save updated task: \(error.localizedDescription)")
            }
        }
        leftBtnClouser?()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rightBtnAction(_ sender: Any) {
        dismiss()
    }
    
    func dismiss(completion:(()->())? = nil) {
       UIView.animate(withDuration: 0.3, animations: {
          self.CustomBGView.alpha = 0
          self.ContentBGView.alpha = 0
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
