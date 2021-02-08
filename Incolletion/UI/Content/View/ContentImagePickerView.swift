//
//  ContentImagePickerView.swift
//  Incolletion
//
//  Created by Анатолий Ем on 31.01.2021.
//

import UIKit
import CoreGraphics
import SnapKit

protocol ContentImagePickerViewDelegate: class {
    func didChangePosition(with yPosition : CGFloat)
    func endChangedPosition(with yPosition : CGFloat)
}

class ContentImagePickerView: UIView {
    
    private lazy var viewModel = makeViewModel()
    
    private let panGesture = UIPanGestureRecognizer()
    private var tapGesture = UITapGestureRecognizer()
    private var collectionView: ContentImagePickerCollectionView!
    private var headerView: UIView!
    private var imageView: UIImageView!
    
    private var panGestureAnchorPoint: CGPoint?
    private var currentYPosition : CGFloat!
    private var startYPosition : CGFloat!
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat {
        return onTop
            ? Constrains.pickerDeployedCornerRadius
            : Constrains.pickerCollapsedCornerRadius
    }
    
    private var onTop: Bool = true
    
    weak var delegate : ContentImagePickerViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startYPosition = frame.origin.y
        currentYPosition = startYPosition
        setupHeaderView()
        setupPanGesture()
        setupTapGesture()
        setupCollectionView()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setupShadow()
    }
    
    private func setupImageView() {
        imageView = UIImageView(image: UIImage(named: "plus"))
        addSubview(imageView)
        let margin: CGFloat = 7
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(margin)
            make.left.equalTo(snp.left).offset(margin)
            make.right.equalTo(snp.right).offset(-margin)
            make.bottom.equalTo(snp.bottom).offset(-margin)
        }
        
        imageView.isHidden = true
    }
}


// MARK: - Setup UI
extension ContentImagePickerView {
    
    private func setupShadow() {
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            addShadowAndCornerRadius(cornerRadius: cornerRadius,
                                     shadowLayer: shadowLayer)
        }
    }
    
    private func setupHeaderView() {
        headerView = UIView()
        addSubview(headerView)
        
        headerView.backgroundColor = .mainWhite()
        headerView.layer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
        
        headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(Constrains.pickerHeaderViewHeight)
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
    
    private func setupPanGesture() {
        panGesture.addTarget(self, action: #selector(handlePanGesture(_:)))
        panGesture.maximumNumberOfTouches = 1
               
        headerView.addGestureRecognizer(panGesture)
    }
    
    private func setupTapGesture() {
        tapGesture.addTarget(self, action: #selector(tap(_:)))
        
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tap(_ tapRecognized: UITapGestureRecognizer) {
        guard tapGesture == tapRecognized, !onTop else { return }
        
        imageView.isHidden = true
        onTop = true
        animate()
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard  panGesture === gestureRecognizer else { assert(false); return }
        
        let y = changeYPosition(gestureRecognizer,
                                startYPosition: startYPosition,
                                currentYPosition: &currentYPosition,
                                onTop: &onTop,
                                gesturePoint: &panGestureAnchorPoint)
        guard let _ = y else { return }
        
        animate()
    }
    
    private func updateUI() {
        shadowLayer = nil
        layer.sublayers?.remove(at: 0)
        headerView.layer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
        setupShadow()
        if !onTop {
            imageView.isHidden = false
        }
    }
    
    private func animate() {
        if onTop {
            imageView.isHidden = true
        } else {
            self.updateUI()
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
            self.frame = self.onTop
                ? Constrains.pickerDeployedFrame
                : Constrains.pickerСollapsedFrame
        } completion: { (success) in
            if success {
                self.updateUI()
            }
        }
    }
}
