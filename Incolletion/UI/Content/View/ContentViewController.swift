//
//  ContentViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 10.01.2021.
//

import UIKit

class ContentViewController: UIViewController {
    
    private var collectionView: ContentCollectionView!
    private var leftBarButtonItem: ContentLeftBarButtonItem!
    private let titleView = ContentTitleView()
    private var pickerFrame: CGRect {
        return CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
    }
    private var imagePicker: ContentImagePickerView!
    private lazy var viewModel = makeViewModel()
    private lazy var pickerManager = makePickerManager()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadingData()
        setupCollectionView()
        setupNavigationItem()
        setupImagePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImagePicker() {
        
        imagePicker = ContentImagePickerView(frame: pickerFrame)
        imagePicker.delegate = self
        view.addSubview(imagePicker)
        imagePicker.backgroundColor = .red
    }
}

extension ContentViewController {
    
    private func setupCollectionView() {
        collectionView = ContentCollectionView(frame: view.bounds)
        view.addSubview(collectionView)
    }
}

// Setup navigation item
extension ContentViewController {
    
    private func setupNavigationItem() {
        setupTitleView()
        setupLeftButton(title: nil)
        setupRightButton()
    }
    
    private func setupTitleView() {
        navigationItem.titleView = ContentTitleView()
    }
    
    private func setupLeftButton(title: String?) {
        leftBarButtonItem = ContentLeftBarButtonItem(title: title)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func setupRightButton() {
        let addBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        
        addBarItem.tintColor = .buttonDark()
        navigationItem.rightBarButtonItem = addBarItem
    }
    
    @objc private func addPhoto() {
        pickerManager.openGallery()
    }
}

extension ContentViewController: ContentImagePickerViewDelegate {
    
    func didChangePosition(with yPosition: CGFloat) {
        print(yPosition)
    }
    
    func endChangedPosition(with yPosition: CGFloat) {
        print(yPosition)
    }
}

extension ContentViewController: ContentViewControllerViewModelViewModel {
    
    func loadingDataDidFinished(title: String) {
        leftBarButtonItem.updateTitle(title)
        self.collectionView.reloadData()
    }
}
