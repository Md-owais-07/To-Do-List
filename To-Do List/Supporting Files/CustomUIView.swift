//
//  CustomUiView.swift
//  To-Do List
//
//  Created by Owais on 12/07/24.
//

import UIKit

class CustomUIView: UIView {

    // Initialize the view programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfiguration()
    }

    // Initialize the view from a storyboard or nib
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConfiguration()
    }

    // Configure the view's appearance
    func setConfiguration() {
        // Adding tap gesture recognizer to the view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }

    // Handle tap gesture
    @objc private func handleTap() {
        // Start the animation when the view is tapped
        animateView()
    }
    
    // Animate the view
    private func animateView() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.allowUserInteraction, .curveEaseIn],
                       animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.allowUserInteraction, .curveEaseInOut],
                           animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}
