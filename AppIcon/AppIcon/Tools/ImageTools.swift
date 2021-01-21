//
//  ImageTools.swift
//  AppIcon
//
//  Created by mac on 2021/1/21.
//

import Foundation
import AppKit

extension NSImage {
    
    /// png数据
    var pngData: Data? {
        guard
            let tiffRepresentation = tiffRepresentation,
            let bitmapImage = NSBitmapImageRep(data: tiffRepresentation)
            else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
        
    /// 修改图片大小
    /// - Parameters:
    ///   - width: 宽度
    ///   - height: 高度
    /// - Returns: 结果图片
    func resize(width: CGFloat, height: CGFloat) -> NSImage {
        let width = width/2
        let height = height/2
        let img = NSImage(size: CGSize(width: width, height: height))
        img.lockFocus()
        let ctx = NSGraphicsContext.current
        ctx?.imageInterpolation = .high
        let oldRect = NSMakeRect(0, 0, size.width, size.height)
        let newRect = NSMakeRect(0, 0, width, height)
        self.draw(in: newRect, from: oldRect, operation: .copy, fraction: 1)
        img.unlockFocus()
        return img
    }
    
    
    
    /// 保存图片
    /// - Parameter path: 路径
    /// - Returns: 结果
    @discardableResult
    func save(_ path: String) -> Bool {
        guard let url = URL(string: path) else { return false }
        do {
            try pngData?.write(to: url, options: .atomic)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}

