//
//  ImagePickerController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 31.01.2021.
//

import UIKit

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
        picker.sourceType = .photoLibrary
        self.router.presentViewController(with: picker)
    }
}
