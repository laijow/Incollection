//
//  UIView+Extension.swift
//  Incolletion
//
//  Created by Анатолий Ем on 30.01.2021.
//

import UIKit

// MARK: - CAShapeLayer
extension UIView {

    func addShadowAndCornerRadius(cornerRadius: CGFloat, shadowLayer: CAShapeLayer) {
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor

        shadowLayer.shadowColor = UIColor.lightGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 4

        layer.insertSublayer(shadowLayer, at: 0)
    }

}

// MARK: - UIPanGestureRecognizer
extension UIView {
        
    func changeYPosition(_ panGesture: UIPanGestureRecognizer,
                         startYPosition: CGFloat,
                         currentYPosition: inout CGFloat,
                         onTop: inout Bool,
                         gesturePoint: inout CGPoint?) -> CGFloat? {
        switch panGesture.state {
        case .possible:
            break
        case .began:
            gesturePoint = panGesture.location(in: self)
            break
        case .changed:
            guard let oldPoint = gesturePoint else { return nil }
            let gesturePoint = panGesture.location(in: self)
            let yPosition = gesturePoint.y + currentYPosition - oldPoint.y
            
            guard yPosition > startYPosition else {
                return nil
            }
            currentYPosition = yPosition
            frame.origin.y = yPosition
            return nil
        case .ended:
            let heightScreen = frame.size.height + startYPosition
            let maximumFingerTravel: CGFloat = 30
            let headerViewMaxY = heightScreen - Constrains.pickerHeaderViewHeight
             
            let newYPosition: CGFloat
            if !onTop {
                newYPosition = currentYPosition <= heightScreen - maximumFingerTravel * 2 + Constrains.pickerHeaderViewHeight
                    ? startYPosition
                    : headerViewMaxY
            } else {
                newYPosition = currentYPosition <= startYPosition + maximumFingerTravel
                    ? startYPosition
                    : headerViewMaxY
            }
            
            onTop = newYPosition == startYPosition
            return newYPosition
        default:
            break
        }
        return nil
    }
    
}
