//
//  UIView+Extension.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 10.02.25.
//

import UIKit

extension UIView{
    func cardView() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
    }
}
