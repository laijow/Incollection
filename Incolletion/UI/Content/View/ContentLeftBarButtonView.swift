//
//  LeftBarButtonItem.swift
//  Incolletion
//
//  Created by Анатолий Ем on 30.01.2021.
//

import UIKit

class ContentLeftBarButtonView: UIView {
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let width: CGFloat = 110
    private let height: CGFloat = 34
    private let maxWidthLabel: CGFloat = 90
    private var widthLabel: CGFloat {
        return titleLabel.contentWidthLimitation(maxWidth: maxWidthLabel)
    }
    private var widthLabelConstraint: NSLayoutConstraint?
        
    init(title: String?) {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        setupTitleLabel(title)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitle(_ title: String) {
        titleLabel.text = title
        widthLabelConstraint?.isActive = false
        widthLabelConstraint?.constant = widthLabel
        widthLabelConstraint?.isActive = true
        UIView.animate(withDuration: 0.2) {
            self.layoutSubviews()
        }
    }
    
    private func setupTitleLabel(_ title: String?) {
            
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = .buttonDark()
        
        addSubview(titleLabel)
        widthLabelConstraint = titleLabel.widthAnchor.constraint(equalToConstant: widthLabel)
        widthLabelConstraint?.isActive = true
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupImageView() {
        
        let somespace: CGFloat = 5
        let image = UIImage(named: "dropArrow")!.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.tintColor = .buttonDark()
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: somespace),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }
}
