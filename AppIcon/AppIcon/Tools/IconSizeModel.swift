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
        return CGFloat(ceil(size)) * multiplier
    }
    func name() -> String {
        if multiplier == 1 {
            return "ICON-\(size).png"
        }
        return "ICON-\(size)@\(multiplier)x.png"
    }
}

