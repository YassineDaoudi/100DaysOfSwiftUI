//
//  UIColor+Ext.swift
//  HabitTrackingApp
//
//  Created by Yassine DAOUDI on 16/11/2021.
//

import Foundation
import SwiftUI

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
