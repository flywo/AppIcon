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
        if Int(size * 10) % 10 != 0 {
            return "ICON-\(String(format: "%.1f", size))@\(Int(multiplier))x.png"
        }
        return "ICON-\(String(format: "%.f", size))@\(Int(multiplier))x.png"
    }
    static let iOSSizes = [
        IconSizeModel(size: 20, multiplier: 1),
        IconSizeModel(size: 20, multiplier: 2),
        IconSizeModel(size: 20, multiplier: 3),
        IconSizeModel(size: 29, multiplier: 1),
        IconSizeModel(size: 29, multiplier: 2),
        IconSizeModel(size: 29, multiplier: 3),
        IconSizeModel(size: 40, multiplier: 1),
        IconSizeModel(size: 40, multiplier: 2),
        IconSizeModel(size: 40, multiplier: 3),
        IconSizeModel(size: 60, multiplier: 2),
        IconSizeModel(size: 60, multiplier: 3),
        IconSizeModel(size: 76, multiplier: 1),
        IconSizeModel(size: 76, multiplier: 2),
        IconSizeModel(size: 83.5, multiplier: 2),
        IconSizeModel(size: 1024, multiplier: 1)
    ]
    static let macOSSizes = [
        IconSizeModel(size: 16, multiplier: 1),
        IconSizeModel(size: 16, multiplier: 2),
        IconSizeModel(size: 32, multiplier: 1),
        IconSizeModel(size: 32, multiplier: 2),
        IconSizeModel(size: 128, multiplier: 1),
        IconSizeModel(size: 128, multiplier: 2),
        IconSizeModel(size: 256, multiplier: 1),
        IconSizeModel(size: 256, multiplier: 2),
        IconSizeModel(size: 512, multiplier: 1),
        IconSizeModel(size: 512, multiplier: 2)
    ]
    static let watchOSSizes = [
        IconSizeModel(size: 48, multiplier: 1),
        IconSizeModel(size: 55, multiplier: 1),
        IconSizeModel(size: 29, multiplier: 2),
        IconSizeModel(size: 29, multiplier: 3),
        IconSizeModel(size: 80, multiplier: 1),
        IconSizeModel(size: 88, multiplier: 1),
        IconSizeModel(size: 100, multiplier: 1),
        IconSizeModel(size: 172, multiplier: 1),
        IconSizeModel(size: 196, multiplier: 1),
        IconSizeModel(size: 216, multiplier: 1),
        IconSizeModel(size: 1024, multiplier: 1)
    ]
}

