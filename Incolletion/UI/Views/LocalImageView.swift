//
//  LocalImageView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 01.02.2021.
//

import UIKit
import Photos

class LocalImageView: UIImageView {
    
    private let imageManager = PHCachingImageManager()
    
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
        let options = PHImageRequestOptions()
        options.version = .current
        
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _  in
            guard let image = image else { return }
            self.image = image
        }
    }
}
