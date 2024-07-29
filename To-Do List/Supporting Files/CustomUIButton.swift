//
//  CustomUIButton.swift
//  To-Do List
//
//  Created by Owais on 11/07/24.
//

import UIKit

class CustomUIButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setConfiguration() {
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.7)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.5
        layer.cornerRadius = 5.0
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        
//        UIView.animate(withDuration: 0.3,
//                       delay: 0,
//                       options: [.allowUserInteraction, .curveEaseIn],
//                       animations: {
//            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
//        }) { (finished) in
//            
//        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//        
//        UIView.animate(withDuration: 0.3,
//                       delay: 0,
//                       options: [.allowUserInteraction, .curveEaseInOut],
//                       animations: {
//            self.transform = CGAffineTransform.identity
//        }) { (finished) in
//            
//        }
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesCancelled(touches, with: event)
//        
//        UIView.animate(withDuration: 0.1,
//                       delay: 0,
//                       options: [.allowUserInteraction, .curveEaseOut],
//                       animations: {
//            self.transform = CGAffineTransform.identity
//        }) { (finished) in
//
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            UIView.animate(withDuration: 0.2) {
//                self.backgroundColor = #colorLiteral(red: 0, green: 0.5695492029, blue: 0.8296285272, alpha: 1).withAlphaComponent(0.7)
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.8)
                self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
            }
        }

        // Revert appearance when touch ends
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
                self.transform = CGAffineTransform.identity
            }
        }

        // Revert appearance when touch is canceled
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesCancelled(touches, with: event)
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = #colorLiteral(red: 0, green: 0.5695492029, blue: 0.8296285272, alpha: 1)
                self.transform = CGAffineTransform.identity
            }
        }
    
}
