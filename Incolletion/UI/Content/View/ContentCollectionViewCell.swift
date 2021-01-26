//
//  ContentCollectionViewCell.swift
//  Incolletion
//
//  Created by Анатолий Ем on 11.01.2021.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ContentCollectionViewCell"
    
    var viewModel: ContentCollectionViewCellViewModel?
    
    let myImageView: WebImageView = {
       let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8882605433, green: 0.8981810212, blue: 0.9109882712, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        myImageView.frame = bounds
        addSubview(myImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
}

extension ContentCollectionViewCell: ContentCollectionViewCellViewModelDelegate {
    
    func fetchMediaDidFinish(mediaUrl: String) {
        myImageView.set(imageURL: mediaUrl)
    }
}
