//
//  ContentImagePickerCollectionViewCell.swift
//  Incolletion
//
//  Created by Анатолий Ем on 01.02.2021.
//

import UIKit
import Photos

class ContentImagePickerCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ContentImagePickerCollectionViewCell"
    
    private var myImageView: LocalImageView = {
        let imageView = LocalImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .mainWhite()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        setupLocalImageView()
    }
    
    override func prepareForReuse() {
        
        myImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ photo: PHAsset) {
        self.myImageView.fetchImage(asset: photo, contentMode: .aspectFill, targetSize: self.frame.size)
    }
    
    private func setupLocalImageView() {
        addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: topAnchor),
            myImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            myImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
