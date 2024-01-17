//
//  UIButton+Extension.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/17/24.
//

import UIKit

extension UIButton {
    func configureButton() {
        self.semanticContentAttribute = .forceRightToLeft
        self.tintColor = .black
    }
    
    func configureChangeButton() {
        self.setTitle("", for: .normal)
        self.setImage(UIImage(systemName: "arrow.left.and.right.circle.fill"), for: .normal)
        self.tintColor = .gray
    }
    
    func configureTranslateButton() {
        self.setTitle("번역", for: .normal)
        self.tintColor = .systemGreen
        self.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        self.layer.cornerRadius = 10
    }
}
