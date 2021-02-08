//
//  Constrains.swift
//  Incolletion
//
//  Created by Анатолий Ем on 07.02.2021.
//

import Foundation
import UIKit

struct Constrains {
    static var screenFrame: CGRect? {
        (UIApplication.shared.delegate as? AppDelegate)?.window?.frame
    }
    static var pickerHeight: CGFloat {
        return (screenFrame?.size.height ?? 0) / 1.5
    }
    static let pickerDeployedCornerRadius: CGFloat = 12
    static let margin: CGFloat = 16
    static let pickerCollapsedSize = CGSize(width: 50, height: 50)
    static let pickerHeaderViewHeight: CGFloat = 50
    static let pickerCollapsedCornerRadius: CGFloat = pickerCollapsedSize.width/2
    static var pickerСollapsedFrame: CGRect {
        let y = (screenFrame?.maxY ?? 0) - 100
        let x = (screenFrame?.maxX ?? 0)  - (pickerCollapsedSize.width + margin)
        return CGRect(x: x,
                      y: y,
                      width: pickerCollapsedSize.width,
                      height: pickerCollapsedSize.height)
    }
    static var pickerDeployedFrame: CGRect {
        let y = (screenFrame?.maxY ?? 0) - pickerHeight
        return CGRect(x: 0,
                      y: y,
                      width: (screenFrame?.size.width ?? 0),
                      height: pickerHeight)
    }
}
