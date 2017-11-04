//
//  UIButtonExtensions.swift
//  LeaFinder
//
//  Created by Alisson L. Selistre on 04/11/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable
    var cornerRadius: Int {
        get {
            return Int(layer.cornerRadius)
        }
        set {
            layer.cornerRadius = CGFloat(newValue)
        }
    }

    @IBInspectable
    var borderWidth: Int {
        get {
            return Int(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
