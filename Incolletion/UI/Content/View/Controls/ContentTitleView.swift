//
//  ContentTitleView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 31.01.2021.
//

import UIKit

class ContentTitleView: UIView {
    
    init() {
        let frame = CGRect(x: 0, y: 0, width: 70, height: 44)
        super.init(frame: frame)
        
        let titleImageView = UIImageView(image: UIImage(named: "preview")!)
        
        titleImageView.frame = bounds
        titleImageView.contentMode = .scaleAspectFit
        addSubview(titleImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
