//
//  NSObject+Extension.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 10.02.25.
//

import UIKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
