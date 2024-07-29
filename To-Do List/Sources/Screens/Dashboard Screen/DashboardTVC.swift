//
//  DashboardTVC.swift
//  To-Do List
//
//  Created by Owais on 22/06/24.
//

import UIKit

class DashboardTVC: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTaskStatus: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.CornerRadiousFinal(radius: 6, color: .systemGray, borderWidth: 1)
        mainView.layer.shadowOpacity = 0.1
        lblTaskStatus.CornerRadiousFinal(radius: 8, color: nil, borderWidth: nil, masksBounds: true)
    }
    
}
