//
//  UiViewExtension.swift
//  To-Do List
//
//  Created by Owais on 21/06/24.
//

import Foundation
import UIKit

extension UIView {
    
    func CornerRadious() {
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.007898840122, green: 0.7087070346, blue: 1, alpha: 1)
    }
    
    func TextFieldCornerRadious() {
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 0.8
        layer.borderColor = #colorLiteral(red: 0.007898840122, green: 0.7087070346, blue: 1, alpha: 1)
    }
    
    func ViewCornerRadious() {
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    func RoundView() {
        let size = CGSize(width: 70, height: 70)
        layer.cornerRadius = size.width/2
         clipsToBounds = true
        layer.borderColor = #colorLiteral(red: 0, green: 0.5695492029, blue: 0.8296285272, alpha: 1)
         layer.borderWidth = 2.0
    }
    
    func CornerRadiousFinal(radius: CGFloat = 0, color: UIColor? = nil, borderWidth: CGFloat? = 0, masksBounds: Bool? = false) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth ?? 0
        self.layer.borderColor = color?.cgColor
        self.layer.masksToBounds = masksBounds ?? false
    }
    
    func CornerRadiousBtn() {
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.007898840122, green: 0.7087070346, blue: 1, alpha: 1)
    }
}
