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
    
    private let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8882605433, green: 0.8981810212, blue: 0.9109882712, alpha: 1)
        return imageView
    }()
    
    private let typeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        setupWebImageView()
        setupTypeImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
            
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    private func setupWebImageView() {
        addSubview(myImageView)
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: topAnchor),
            myImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            myImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupTypeImageView() {
        addSubview(typeImageView)
        NSLayoutConstraint.activate([
            typeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            typeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            typeImageView.heightAnchor.constraint(equalToConstant: 20),
            typeImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}

extension ContentCollectionViewCell: ContentCollectionViewCellViewModelDelegate {
    
    func fetchMediaDidFinish(mediaUrl: String, typeImage: UIImage) {
        myImageView.set(imageURL: mediaUrl)
        
        typeImageView.image = typeImage
    }
}
