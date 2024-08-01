//
//  DeletedCellVCViewController.swift
//  To-Do List
//
//  Created by Owais on 24/07/24.
//

import UIKit
import CoreData
import FirebaseAuth

class DeletedCellVC: AppUiViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblDeletedText: UILabel!
    @IBOutlet weak var btnClearall: UIButton!
    @IBOutlet weak var lblDeletedDesc: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    var deletedTasks: [UserDataEntity] = []
    let titleBtn = "CLEAR ALL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DashboardTVC", bundle: nil), forCellReuseIdentifier: "cell")
        
        fetchDeletedTasks()
        
        lblDeletedText.text = "History is Empty"
        lblDeletedDesc.text = "No deleted tasks were found."
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDeletedTasks()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearBtnAction(_ sender: Any) {
            let alert = UIAlertController(title: "Clear Data", message: "Are you sure, you want to permanently erase all data?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                do {
                    self.clearAllDeletedTasks()
                    self.toastView(toastMessage: "Data erased successfuly.", type: "success")
                } catch {
                    print("ERASING DATA ERROR WITH: \(error.localizedDescription)")
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
    }
    
    func clearAllDeletedTasks() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user is logged in.")
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserDataEntity> = UserDataEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "isRemoved == %@ AND userID == %@", NSNumber(value: true), userID)
        
        do {
            let deletedTasks = try context.fetch(fetchRequest)
            
            for task in deletedTasks {
                context.delete(task)
            }
            
            try context.save()
            
            fetchDeletedTasks()
            
            print("Deleted tasks cleared successfully.")
            
        } catch {
            print("ERROR CLEARING DELETED TASKS: ", error.localizedDescription)
        }
    }
    
    func fetchDeletedTasks() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No user is logged in.")
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserDataEntity> = UserDataEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "isRemoved == %@ AND userID == %@", NSNumber(value: true), userID)
        
        do {
            deletedTasks = try context.fetch(fetchRequest)
            
            if deletedTasks.isEmpty {
                btnClearall.isHidden = true
                tableView.isHidden = true
                lblDeletedText.isHidden = false
                lblDeletedDesc.isHidden = false
                lblDeletedText.text = "History is Empty"
                lblDeletedDesc.text = "No deleted tasks were found."
            } else {
                btnClearall.isHidden = false
                tableView.isHidden = false
                lblDeletedText.isHidden = true
                lblDeletedDesc.isHidden = true
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: UIColor.label,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                let attributedString = NSMutableAttributedString(string: titleBtn, attributes: attributes)
                btnClearall.setAttributedTitle(attributedString, for: .normal)
                tableView.reloadData()
            }
            
        } catch {
            print("FETCHING DELETED TASKS ERROR WITH: ", error.localizedDescription)
        }
    }
}

extension DeletedCellVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deletedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DashboardTVC else { return UITableViewCell() }
        let task = deletedTasks[indexPath.row]
        cell.lblTitle.text = task.todo
        cell.lblSubtitle.text = task.descriptions
        cell.lblTaskStatus.text = task.status
        cell.lblTaskStatus.backgroundColor = UIColor.red
        return cell
    }
    
}
