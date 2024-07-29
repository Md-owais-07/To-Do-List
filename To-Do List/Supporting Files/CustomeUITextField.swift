//
//  CustomeUITextField.swift
//  To-Do List
//
//  Created by Owais on 29/06/24.
//

import Foundation
import UIKit

class CustomeUITextField: UITextField {
    var errorClosure: (() -> ())?
    
    func setErrorTheme(errorAction: @escaping (() -> ()))
    {
        errorClosure = errorAction
    }
}
