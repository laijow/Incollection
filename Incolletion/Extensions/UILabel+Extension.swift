//
//  UILabel+Extension.swift
//  Incolletion
//
//  Created by Анатолий Ем on 30.01.2021.
//

import UIKit

extension UILabel {
    
    func contentWidthLimitation(maxWidth: CGFloat) -> CGFloat {
        let currentWidth = intrinsicContentSize.width
        return currentWidth > maxWidth ? maxWidth : currentWidth
    }
}
