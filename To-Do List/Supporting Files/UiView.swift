//
//  UiView.swift
//  To-Do List
//
//  Created by Owais on 29/07/24.
//

import UIKit

class AppHeaderView: UIView {
   required init?(coder: NSCoder) {
      super.init(coder: coder)
       self.setShadow()
   }
}

class AppStatusBar: UIView {
   required init?(coder: NSCoder) {
      super.init(coder: coder)
       self.setBackgroundColor(color: UIColor.black)
   }
}

extension UIView {
    func setShadow(radius: CGFloat = 5, opacity: Float = 0.5, color: UIColor = UIColor.lightGray, offset: CGSize = CGSize.zero)
    {
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
    }
    func setBackgroundColor(color: UIColor) {
       self.backgroundColor = color
    }
}
