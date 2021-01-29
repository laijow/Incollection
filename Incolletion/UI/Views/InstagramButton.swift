//
//  InstagramButton.swift
//  Incolletion
//
//  Created by Анатолий Ем on 29.01.2021.
//

import UIKit

class InstagramButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        setupFacing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupFacing() {
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
    
    private func setupGradientColors() {
        gradientLayer.colors = [#colorLiteral(red: 0.2509803922, green: 0.3647058824, blue: 0.9019607843, alpha: 1).cgColor, #colorLiteral(red: 0.3450980392, green: 0.3176470588, blue: 0.8588235294, alpha: 1).cgColor, #colorLiteral(red: 0.5137254902, green: 0.2274509804, blue: 0.7058823529, alpha: 1).cgColor, #colorLiteral(red: 0.7568627451, green: 0.2078431373, blue: 0.5176470588, alpha: 1).cgColor, #colorLiteral(red: 0.8823529412, green: 0.1882352941, blue: 0.4235294118, alpha: 1).cgColor, #colorLiteral(red: 0.9921568627, green: 0.1137254902, blue: 0.1137254902, alpha: 1).cgColor]
    }
}
