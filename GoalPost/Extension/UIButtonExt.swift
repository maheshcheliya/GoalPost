//
//  UIButtonExt.swift
//  GoalPost
//
//  Created by Mahesh on 29/10/20.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = UIColor(named: "headerColor")
    }
    
    func setDeselectedColor() {
        self.backgroundColor = UIColor(named: "deselectedBtnColor")
    }
}
