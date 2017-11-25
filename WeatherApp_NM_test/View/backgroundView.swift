//
//  backgroundView.swift
//  WeatherApp_NM_test
//
//  Created by Jakub Majewski on 25.11.2017.
//  Copyright © 2017 Jakub Majewski. All rights reserved.
//

import UIKit

private var key = false

@IBDesignable
class backgroundView: UIView {

    @IBInspectable var roundCorners: Bool {
        get {
            return key
        }
        set {
            key = newValue
            roundCorners(value: newValue)
        }
    }
    
    private func roundCorners(value: Bool){
        if value {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 15.0
            self.layer.opacity = 0.5
        } else {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 0
            self.layer.opacity = 1
        }
    }
}
