//
//  App Controller.swift
//  To-Do List
//
//  Created by Owais on 21/06/24.
//

import Foundation
import UIKit

class AppStoryBoard {
    static let shared = AppStoryBoard()
    var Main: UIStoryboard {
        UIStoryboard(name: "Main", bundle: nil)
    }
}

class AppController {
    static let shared = AppController()
    
    var loginVC: LoginVC {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "LoginVC_id") as? LoginVC ?? LoginVC()
    }
    var signUpVC: SignupVC {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "SignupVC_id") as? SignupVC ?? SignupVC()
    }
    var dashboardVC: DashboardVC {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "DashboardVC_id") as? DashboardVC ?? DashboardVC()
    }
    var addItem: AddItemVCViewController {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "AddItemVCViewController_id") as? AddItemVCViewController ?? AddItemVCViewController()
    }
    var profileVC: ProfileVC {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "ProfileVC_id") as? ProfileVC ?? ProfileVC()
    }
    var editProfileVC: EditProfileVC {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "EditProfileVC_id") as? EditProfileVC ?? EditProfileVC()
    }
    var startVC: WelcomeVC {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "ViewController_id") as? WelcomeVC ?? WelcomeVC()
    }
    var bottomSheet: BottomSheetVCViewController {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "BottomSheetVCViewController_id") as? BottomSheetVCViewController ?? BottomSheetVCViewController()
    }
    var gotoVC: DeletedCellVC {
        AppStoryBoard.shared.Main.instantiateViewController(withIdentifier: "DeletedCellVCViewController_id") as? DeletedCellVC ?? DeletedCellVC()
    }
    var dashboardVCd: DashboardVC {
        return DashboardVC()
    }
    var startVCd: WelcomeVC {
        return WelcomeVC()
    }
}
