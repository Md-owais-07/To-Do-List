//
//  DashboardVC.swift
//  To-Do List
//
//  Created by Owais on 22/06/24.
//

import UIKit
import CoreData

class DashboardVC: AppUiViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var lblCompleteStatus: UILabel!
    @IBOutlet weak var lblCompleteNumber: UILabel!
    @IBOutlet weak var ongoingView: UIView!
    @IBOutlet weak var lblOngoing: UILabel!
    @IBOutlet weak var lblOngoingNumber: UILabel!
    @IBOutlet weak var deletedView: UIView!
    @IBOutlet weak var lblDeleted: UILabel!
    @IBOutlet weak var lblDeletedNumber: UILabel!
    @IBOutlet weak var dayStatusView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var btnAddItem: UIButton!
    @IBOutlet weak var lblRecentView: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var recentView: UIView!
    @IBOutlet weak var lblGreeting: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    var userData: [UserDataEntity] = []
    var timer: Timer?
    var deleteCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeaderView.ViewCornerRadious()
        completedView.ViewCornerRadious()
        ongoingView.ViewCornerRadious()
        deletedView.ViewCornerRadious()
        dayStatusView.ViewCornerRadious()
        btnAddItem.layer.cornerRadius = 8
        fetchData()
        
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DashboardTVC", bundle: nil), forCellReuseIdentifier: "cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFetch), name: .reloadFetchData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFetch), name: .updateRefresh, object: nil)
        
        updateRecentViewLabel()
        updateGreeting()
        startTimer()
        updateLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblUserName.text = "Hi, \(UserData.shared.fullName)"
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController {
            let count = navigationController.viewControllers.count
            print("Number of view controllers in the navigation stack - DashboardVC: \(count)")
        }
        UIView.animate(withDuration: 0.9, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0) {
            self.lblRecentView.alpha = 1
        }
    }
    
    @objc func updateGreeting() {
        let currentDateTime = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDateTime)
        let greeting: String
        
        switch hour {
        case 5..<12:
            greeting = "Good Morning 🌅"
        case 12..<17:
            greeting = "Good Afternoon ☀️"
        case 17..<22:
            greeting = "Good Evening 🌇"
        default:
            greeting = "Good Night 🌃"
        }
        
        lblGreeting.text = greeting
    }
    
    @objc func reloadFetch(_ notification: Notification) {
        fetchData()
        print("RELOAD FETCH DATA NOTIFICATION.")
    }
    
    @IBAction func additemBtnAction(_ sender: Any) {
        let vc = AppController.shared.bottomSheet
        vc.title = "Add Task"
        
        let sheet = vc.sheetPresentationController
        sheet?.detents = [.medium(), .medium()]
        
        sheet?.preferredCornerRadius = 20
        sheet?.prefersScrollingExpandsWhenScrolledToEdge = false
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .pageSheet
        navigationController.isModalInPresentation = true
        navigationController.sheetPresentationController?.detents = [.medium(), .large()]
        // Customize navigation bar to add a separator line
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // Transparent background
        appearance.shadowColor = .lightGray // Separator line color
        
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.label, // Set title color here
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        let separator = UIImage(color: .lightGray, size: CGSize(width: 1, height: 1))
        appearance.shadowImage = separator // Set separator height
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        
        present(navigationController, animated: true)
    }
    
    @IBAction func profileBtnAction(_ sender: Any) {
        let vc = AppController.shared.profileVC
        navigationController?.pushViewController(vc, animated: true)
        print("profile tapped...")
    }
    
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserDataEntity> = UserDataEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isRemoved == %@", NSNumber(value: false)) // Fetch only non-deleted tasks
        
        do {
            self.userData = try context.fetch(fetchRequest)
            print("DATA IS FETCHING FROM CORE DATA...")
            DispatchQueue.main.async {
                self.updateRecentViewLabel()
                self.updateCompleteTasksCount()
                self.updateOngoingTaskCount()
                self.updateTodoTasksCount()
                self.tableView.reloadData()
                print("DATA IS FETCHING AFTER DispatchQueue.main.async...")
            }
            
        } catch {
            print("Error fetching data from Core Data: \(error.localizedDescription)")
        }
    }

    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateGreeting), userInfo: nil, repeats: true)
    }
    
    func updateLabels() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let currentDate = Date()
        
        lblDay.text = getDayOfWeek(currentDate)
        lblDate.text = "\(dateFormatter.string(from: currentDate)) \(timeFormatter.string(from: currentDate))"
    }
    
    func getDayOfWeek(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func updateRecentViewLabel() {
        lblRecentView.alpha = 0
        if userData.isEmpty {
            UIView.animate(withDuration: 0.8, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0) {
                self.lblRecentView.alpha = 1
                self.lblRecentView.text = "No Recently Task? Please Add New Task."
                self.lblRecentView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            }
        } else {
            self.lblRecentView.alpha = 1
            self.lblRecentView.text = "To Do Task:"
            self.lblRecentView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
    
    func updateCompleteTasksCount() {
        var completeCount = 0
        lblDeletedNumber.alpha = 0.1
        for user in userData {
            if user.status == "Completed" || user.status == "Complete" {
                completeCount += 1
            }
        }
        UIView.animate(withDuration: 0.8, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0) {
            self.lblDeletedNumber.alpha = 1
            self.lblDeletedNumber.text = "\(completeCount)"
        }
    }
    
    func updateTodoTasksCount() {
        var todoCount = 0
        lblCompleteNumber.alpha = 0.1
        for user in userData {
            if user.status == "To Do" || user.status == "to do" {
                todoCount += 1
            }
        }
        UIView.animate(withDuration: 0.8, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0) {
            self.lblCompleteNumber.alpha = 1
            self.lblCompleteNumber.text = "\(todoCount)"
        }
        
    }
    
    func updateOngoingTaskCount() {
        var ongoingCount = 0
        lblOngoingNumber.alpha = 0.1
        for user in userData {
            if user.status == "Ongoing" || user.status == "ongoing" {
                ongoingCount += 1
            }
        }
        UIView.animate(withDuration: 0.8, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0) {
            self.lblOngoingNumber.alpha = 1
            self.lblOngoingNumber.text = "\(ongoingCount)"
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .reloadFetchData, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateDeleteLblNumber, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateRefresh, object: nil)
        timer?.invalidate()
    }
    
}

extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DashboardTVC else { return UITableViewCell()
        }
        
        let data = self.userData[indexPath.row]
        
        cell.lblTitle.text = data.todo
        cell.lblSubtitle.text = data.descriptions
        cell.lblTaskStatus.text = data.status
        
        if cell.lblTaskStatus.text == "Completed" ||
            cell.lblTaskStatus.text == "Complete" {
            cell.lblTaskStatus.backgroundColor = #colorLiteral(red: 0.5943713188, green: 0.9863030314, blue: 0.5960182548, alpha: 1)
            cell.lblTaskStatus.textColor = #colorLiteral(red: 0, green: 0.3905539811, blue: 0, alpha: 1)
        } else if cell.lblTaskStatus.text == "Ongoing" {
            cell.lblTaskStatus.backgroundColor = #colorLiteral(red: 1, green: 0.8982682824, blue: 0.5693842173, alpha: 1)
            cell.lblTaskStatus.textColor = #colorLiteral(red: 1, green: 0.5496008396, blue: 0, alpha: 1)
        } else if cell.lblTaskStatus.text == "To Do" {
            cell.lblTaskStatus.backgroundColor = #colorLiteral(red: 0.6800740361, green: 0.8480283618, blue: 0.901022017, alpha: 1)
            cell.lblTaskStatus.textColor = #colorLiteral(red: 0.008812314831, green: 0.2433405221, blue: 0.6229481101, alpha: 1)
        } else if cell.lblTaskStatus.text == "Deleted" {
            cell.lblTaskStatus.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.lblTaskStatus.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            cell.lblTaskStatus.backgroundColor = UIColor.systemBlue
            cell.lblTaskStatus.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            self.deleteTask(at: indexPath)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { action, view, completionHandler in
            let data = self.userData[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let vc = storyboard.instantiateViewController(withIdentifier: "AddItemVCViewController_id") as? AddItemVCViewController {
                // Set the task data to be edited
                vc.taskTitle = data.todo ?? "No data found!"
                vc.taskDesc = data.descriptions ?? "No data found!"
                vc.taskStatus = data.status ?? "No data found!"
                
                // Set the managed object context
                vc.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                vc.task = data // Pass the task object
                
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                    window.rootViewController?.present(vc, animated: true, completion: nil)
                } else {
                    print("No suitable UIWindowScene or window found.")
                }
            }
            
            completionHandler(true)
        }
        
        editAction.backgroundColor = #colorLiteral(red: 0, green: 0.6796290278, blue: 1, alpha: 1)
        
        let configurationSwipe = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configurationSwipe.performsFirstActionWithFullSwipe = true
        return configurationSwipe
    }
    
    func deleteTask(at indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = userData[indexPath.row]
        
        task.isRemoved = true
        
        do {
            try context.save()
            userData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print("USER DATA IS MARKED AS DELETED - func deleteTask")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.updateRecentViewLabel()
                self.updateCompleteTasksCount()
                self.updateOngoingTaskCount()
                self.updateTodoTasksCount()
            }
        } catch {
            print("MARKING USER DATA AS DELETED ERROR WITH: ", error.localizedDescription)
        }
    }
}
