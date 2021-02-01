//
//  ContentImagePickerView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 31.01.2021.
//

import UIKit

protocol ContentImagePickerViewDelegate: class {
    func didChangePosition(with yPosition : CGFloat)
    func endChangedPosition(with yPosition : CGFloat)
}

class ContentImagePickerView: UIView {
    private let panGesture = UIPanGestureRecognizer()
    private var collectionView: ContentImagePickerCollectionView!
    private lazy var viewModel = makeViewModel()
    private var panGestureAnchorPoint: CGPoint?
    private var oldYPosition : CGFloat = 0
    private var startYPosition : CGFloat {
        return frame.origin.y
    }
    
    weak var delegate : ContentImagePickerViewDelegate!
         
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPunGesture()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView = ContentImagePickerCollectionView(frame: bounds)
        addSubview(collectionView)
    }
    
    func transitionToStartPosition() {
        
        guard startYPosition != 0 else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.startYPosition, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
}

extension ContentImagePickerView {
    
    private func setupPunGesture() {
        panGesture.addTarget(self, action: #selector(handlePanGesture(_:)))
        panGesture.maximumNumberOfTouches = 1
               
        addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        guard  panGesture === gestureRecognizer else { assert(false); return }
        
        switch gestureRecognizer.state {
        case .possible:
            break
        case .began:
            panGestureAnchorPoint = gestureRecognizer.location(in: self)
            break
        case .changed:
             guard let oldPoint = panGestureAnchorPoint else { return }
             let gesturePoint = gestureRecognizer.location(in: self)
             let yPosition = gesturePoint.y + oldYPosition - oldPoint.y
             if yPosition > 100 {
                oldYPosition = yPosition
                frame = CGRect(x: frame.origin.x, y: yPosition, width: frame.size.width, height: frame.size.height)
             }
             
            delegate?.didChangePosition(with: yPosition)
            break
        case .cancelled:
            break
        case .ended:
            delegate?.endChangedPosition(with: oldYPosition)
            break
        case .failed:
            assert(panGestureAnchorPoint == nil)
            break
        @unknown default:
            fatalError("Unknow state recognizer")
        }
    }
}
