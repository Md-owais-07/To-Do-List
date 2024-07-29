//
//  ToastView.swift
//  To-Do List
//
//  Created by Owais on 02/07/24.
//

import UIKit

class ToastView: UIView {
    
    @IBOutlet weak var toastImage: UIImageView!
    @IBOutlet weak var toastLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("ToastView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    func statusCheck(status:String,message:String,widthis:CGFloat)
    {
        mainViewHeight.constant = widthis
        toastLabel.text = message
        var image = UIImage(named: "green_tick")
        switch status {
        case "success":
            mainView.backgroundColor = #colorLiteral(red: 0, green: 0.8, blue: 0.07058823529, alpha: 1)
            toastLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            image = UIImage(named: "green_tick")
            break
        case "error":
            mainView.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9294117647, blue: 0.937254902, alpha: 1)
            image = UIImage(named: "error_icon")
            break
        case "warning":
            mainView.backgroundColor = #colorLiteral(red: 1, green: 0.9764705882, blue: 0.9176470588, alpha: 1)
            image = UIImage(named: "warning_icon")
            break
        default:
            toastLabel.backgroundColor = UIColor.white
            image = UIImage(named: "green_tick")
        }
        
        toastImage.image = image
    }

}
