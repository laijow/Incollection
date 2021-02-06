//
//  ContentImagePickerView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 31.01.2021.
//

import UIKit
import SnapKit

protocol ContentImagePickerViewDelegate: class {
    func didChangePosition(with yPosition : CGFloat)
    func endChangedPosition(with yPosition : CGFloat)
}

class ContentImagePickerView: UIView {
    
    private lazy var viewModel = makeViewModel()
    
    private let panGesture = UIPanGestureRecognizer()
    private var collectionView: ContentImagePickerCollectionView!
    private var headerView: UIView!
    private var panGestureAnchorPoint: CGPoint?
    private var oldYPosition : CGFloat!
    private var startYPosition : CGFloat!
    private let heightHeaderView: CGFloat = 50
    private var onTop: Bool = true
    
    weak var delegate : ContentImagePickerViewDelegate!
    
    private var shadowLayer: CAShapeLayer!
         
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startYPosition = frame.origin.y
        oldYPosition = startYPosition
        setupHeaderView()
        setupPunGesture()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = .clear
        setupShadow()
    }
        
    private func animatePosition(withYPosition yPosition: CGFloat) {
        guard startYPosition != 0 else {
            return
        }
        
        onTop = yPosition == startYPosition
        UIView.animate(withDuration: 0.2) {
            self.frame.origin.y = yPosition
        }
    }
}


// MARK: - Setup UI
extension ContentImagePickerView {
    
    private func setupShadow() {
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.lightGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 4

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    private func setupHeaderView() {
        headerView = UIView()
        addSubview(headerView)
        
        headerView.backgroundColor = .mainWhite()
        headerView.layer.cornerRadius = 10
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(heightHeaderView)
        }
    }
    
    private func setupCollectionView() {
        collectionView = ContentImagePickerCollectionView(frame: CGRect.zero)
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}

extension ContentImagePickerView {
    
    private func setupPunGesture() {
        panGesture.addTarget(self, action: #selector(handlePanGesture(_:)))
        panGesture.maximumNumberOfTouches = 1
               
        headerView.addGestureRecognizer(panGesture)
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
            
            guard yPosition > startYPosition else {
                oldYPosition = startYPosition
                return
            }
            oldYPosition = yPosition
            frame.origin.y = yPosition
             
            delegate?.didChangePosition(with: yPosition)
            break
        case .cancelled:
            break
        case .ended:
            let heightScreen = frame.size.height + startYPosition
            let maximumFingerTravel: CGFloat = 30
            let headerViewMaxY = heightScreen - heightHeaderView
             
            let newYPosition: CGFloat
            if !onTop {
                newYPosition = oldYPosition <= heightScreen - maximumFingerTravel * 2 + heightHeaderView
                    ? startYPosition
                    : headerViewMaxY
            } else {
                newYPosition = oldYPosition <= startYPosition + maximumFingerTravel
                    ? startYPosition
                    : headerViewMaxY
            }
             
            animatePosition(withYPosition: newYPosition)
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
