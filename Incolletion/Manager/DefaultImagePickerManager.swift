//
//  ImagePickerController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 31.01.2021.
//

import UIKit
import Photos
import PhotosUI

class DefaultImagePickerManager: NSObject {
    
    private var picker = UIImagePickerController()
    private let router: Router
    
    init(router: Router) {
        self.router = router
        super.init()
    }
}

extension DefaultImagePickerManager: ImagePickerManager {
    func openGallery() {
        if #available(iOS 14, *) {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 0
            configuration.filter = .any(of: [.images, .livePhotos])
            let picker = PHPickerViewController(configuration: configuration)
            
            self.router.presentViewController(with: picker)
        }
        picker.sourceType = .photoLibrary
        self.router.presentViewController(with: picker)
    }
}
