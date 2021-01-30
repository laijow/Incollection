//
//  ContentNavigationBar.swift
//  Incolletion
//
//  Created by Анатолий Ем on 30.01.2021.
//

import UIKit

class ContentNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shadowImage = UIImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
