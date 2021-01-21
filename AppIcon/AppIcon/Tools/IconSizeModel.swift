//
//  IconSizeModel.swift
//  AppIcon
//
//  Created by mac on 2021/1/21.
//

import Foundation


struct IconSizeModel {
    let size: CGFloat
    let multiplier: CGFloat
    func width() -> CGFloat {
        return size * multiplier
    }
    func name() -> String {
        if multiplier == 1 {
            if Int(size * 10) % 10 != 0 {
                return "ICON-\(String(format: "%.1f", size)).png"
            }
            return "ICON-\(String(format: "%.f", size)).png"
        }
        if Int(size * 10) % 10 != 0 {
            return "ICON-\(String(format: "%.1f", size))@\(Int(multiplier))x.png"
        }
        return "ICON-\(String(format: "%.f", size))@\(Int(multiplier))x.png"
    }
}

