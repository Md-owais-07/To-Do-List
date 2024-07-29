//
//  CustomUiViewVC.swift
//  To-Do List
//
//  Created by Owais on 23/06/24.
//

import UIKit

extension AppUiViewController {
    
//    func showAlert(leftactionTitle: String = "OK", rightactionTitle: String = "Cancel", rightAction: @escaping ()->()) {
//        DispatchQueue.main.async {
//            let popUpVC = AppController.shared.addItem
//            popUpVC.rightBtnActionClosure = rightAction
//            popUpVC.rightBtnTitle = rightactionTitle
//            popUpVC.leftBtnTitle = leftactionTitle
//            popUpVC.modalTransitionStyle = .crossDissolve
//            popUpVC.modalPresentationStyle = .overCurrentContext
//            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let window = scene.windows.first {
//                window.rootViewController?.present(popUpVC, animated: false, completion: nil)
//            }
//        }
//    }
    
    func HideKeyboardWhenTapAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func toastView(toastMessage: String, visibleDuration: TimeInterval = 3,type: String) {
        DispatchQueue.main.async {
            let status = Network.isAvailable()
            let message = !status ? "No Internet Connection" : toastMessage
            
            let contentSize = message.boundingRect(with: CGSize(width: (self.view.frame.width * 0.85), height: 100), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], context: nil)
            
            let width: CGFloat = self.view.frame.size.width ///- 40
            let xPosition: CGFloat = ((self.view.frame.width - width) / 2)
            let contentWidth = message.size(withAttributes:[.font: UIFont.systemFont(ofSize: 13)]).width
            
            var contentLineCount = 0
            let widthText = width-54
            
            if widthText <= contentWidth
            {
                let line = Int(contentWidth/widthText)
                if (CGFloat(line) * widthText) < contentWidth
                {
                    contentLineCount = Int(line+2)
                }
                else
                {
                    contentLineCount = Int(line+1)
                }
            }
            else
            {
                contentLineCount = 1
            }
            let contentHeight = (Int(message.size(withAttributes:[.font: UIFont.systemFont(ofSize: 13)]).height) * contentLineCount)+20
            let height: CGFloat = CGFloat(contentHeight)
            ///let yPosition: CGFloat = ((self.view.frame.height - height) - 200)
            let toastTextView = ToastView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
            let windows = UIApplication.shared.windows.last
            windows?.addSubview(toastTextView)
            toastTextView.statusCheck(status: type, message: message,widthis:(self.view.frame.size.width - 40))
            UIView.animate(withDuration: 0.3, animations: {
                toastTextView.alpha = 1
            }, completion: nil)
            Timer.scheduledTimer(withTimeInterval: visibleDuration, repeats: false, block: { (timer) in
                timer.invalidate()
                UIView.animate(withDuration: 0.3, animations: {
                    toastTextView.alpha = 0
                }, completion: { (completed) in
                    if completed {
                        toastTextView.removeFromSuperview()
                    }
                })
            })
        }
    }
    
}
