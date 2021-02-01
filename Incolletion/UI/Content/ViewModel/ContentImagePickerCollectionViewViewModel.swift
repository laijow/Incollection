//
//  ContentImagePickerCollectionView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 01.02.2021.
//

import Foundation
import UIKit
import Photos
import PhotosUI

protocol ContentImagePickerCollectionViewViewModelDelegate: class {
    func loadDidFinishing()
}

class ContentImagePickerCollectionViewViewModel {
    
    enum AuthorizeStatus {
        case authorized
        case limited
    }
    
    private let router: Router
    
    var allPhotos : PHFetchResult<PHAsset>? = nil
    var allImages: [UIImage]? = nil
    var authorizeStatus: AuthorizeStatus = .authorized
    weak var delegate: ContentImagePickerCollectionViewViewModelDelegate!
    
    init(router: Router) {
        self.router = router
        
        getAllPhotos()
    }
    
    func numberOfItemsInSection(_ secion: Int) -> Int {
        let count: Int
        switch authorizeStatus {
        case .authorized:
            count = self.allPhotos?.count ?? 0
        case .limited:
            count = self.allImages?.count ?? 0
        }
        return count
    }
    
    func cellForItemAt(_ indexPath: IndexPath) -> PHAsset {
        return self.allPhotos![indexPath.row]
    }
    
    private func getAllPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                self.authorizeStatus = .authorized
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: nil, ascending: true)]
                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                self.loadDidFinishing()
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            case .limited:
                self.authorizeStatus = .limited
                self.presentPicker()
                break
            @unknown default:
                fatalError("")
            }
        }
    }
    
    private func presentPicker() {
        if #available(iOS 14, *) {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 0
            configuration.filter = .any(of: [.images, .livePhotos])
            let picker = PHPickerViewController(configuration: configuration)
            
            self.router.presentViewController(with: picker)
        }
    }
    
    private func loadDidFinishing() {
        DispatchQueue.main.async {
            self.delegate.loadDidFinishing()
        }
    }
}

@available(iOS 14, *)
extension ContentImagePickerCollectionViewViewModel: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            let provider = result.itemProvider
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [weak self] image, error  in
                    guard let self = self, let image = image else { return }
                    self.allImages?.append(image as! UIImage)
                }
            }
        }
        self.loadDidFinishing()
    }
}
