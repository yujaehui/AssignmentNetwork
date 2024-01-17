//
//  UITextView+Extension.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/17/24.
//

import UIKit

extension UITextView {
    func configureTextView() {
        self.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
}
