//
//  InstagramLoginViewController.swift
//  Incolletion
//
//  Created by Анатолий Ем on 15.01.2021.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class InstagramLoginViewController: UIViewController {
    
    private let customNavBar = UIView()
    private var progressView: UIProgressView!
    private var webViewObservation: NSKeyValueObservation!
    
    private let viewModel: InstagramLoginViewModel
    private let authURL: URL
    
    // Rx
    private let disposeBag = DisposeBag()
    private let relayGetToken = PublishRelay<String>()
    private let relayEndFinish = PublishRelay<InstagramTokenResult>()
    
    init(authUrl: URL, viewModel: InstagramLoginViewModel) {
        self.authURL = authUrl
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCustomNavBar()
        setupProgressView()

        // Initializes web view
        let webView = makeWebView()

        // Starts authorization
        webView.load(URLRequest(url: authURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData))
        
        bindToModel()
    }
    
    deinit {
        progressView.removeFromSuperview()
        webViewObservation.invalidate()
    }

    @objc func dismissViewController() {
        
        dismiss(animated: true, completion: nil)
    }

    private func progressViewChangeHandler<Value>(webView: WKWebView, change: NSKeyValueObservedChange<Value>) {
        progressView.alpha = 1.0
        progressView.setProgress(Float(webView.estimatedProgress), animated: true)

        if webView.estimatedProgress >= 1.0 {
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                self.progressView.alpha = 0.0
            }, completion: { _ in
                self.progressView.progress = 0
            })
        }
    }
}

// MARK: binde to model
extension InstagramLoginViewController {
    
    private func bindToModel() {
        let input = InstagramLoginViewModel.Input(getToken: relayGetToken.asSignal(),
                                                                endFinish: relayEndFinish.asSignal())
        let output = viewModel.transform(from: input)
        
        disposeBag.insert(
            output.beginFinish.drive(onNext: { [weak self] result in
                guard let self = self else { return }
                self.relayEndFinish.accept(result)
            }),
            output.endFinish.drive()
        )
    }
}

// MARK: Make web view
extension InstagramLoginViewController {
    
    private func makeWebView() -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.websiteDataStore = .nonPersistent()

        let webView = WKWebView(frame: view.frame, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false

        webViewObservation = webView.observe(\.estimatedProgress, changeHandler: progressViewChangeHandler)

        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        return webView
    }
}

// MARK: Setup progress view
extension InstagramLoginViewController {
    private func setupProgressView() {

        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progress = 0.0
        progressView.tintColor = UIColor(red: 0.88, green: 0.19, blue: 0.42, alpha: 1.0)
        progressView.translatesAutoresizingMaskIntoConstraints = false

        customNavBar.addSubview(progressView)

        NSLayoutConstraint.activate([
            customNavBar.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 1),
            customNavBar.leadingAnchor.constraint(equalTo: progressView.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: progressView.trailingAnchor)
        ])
    }
}

// MARK: Setup custom navigation bar
extension InstagramLoginViewController {
    private func setupCustomNavBar() {
        let navBarHeight: CGFloat = 50
        let closeButtonMargin: CGFloat = 5
        let titleLabel = UILabel()
        let closeButton = UIButton()
        
        customNavBar.backgroundColor = .white
        
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customNavBar)
        
        // custom navigation bar constraints
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: navBarHeight),
        ])
        
        titleLabel.text = "Авторизация"
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        
        closeButton.tintColor = .black
        closeButton.setImage(UIImage(named: "bottomArrow"), for: .normal)
        closeButton.setTitle("􀄩", for: .normal)
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        customNavBar.addSubview(titleLabel)
        customNavBar.addSubview(closeButton)
        
        // title label constraints
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: customNavBar.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: customNavBar.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: customNavBar.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: customNavBar.bottomAnchor)
        ])
        
        // close button constraints
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: customNavBar.leadingAnchor, constant: closeButtonMargin),
            closeButton.topAnchor.constraint(equalTo: customNavBar.topAnchor, constant: closeButtonMargin),
            closeButton.bottomAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: -closeButtonMargin),
            closeButton.widthAnchor.constraint(equalToConstant: navBarHeight - (closeButtonMargin * 2))
        ])
    }
}

// MARK: - WKNavigationDelegate

extension InstagramLoginViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        let stringURL = navigationAction.request.url!.absoluteString
        
        guard viewModel.authorizeFinished(stringURL: stringURL) else {
            decisionHandler(.allow)
            return
        }

        decisionHandler(.cancel)

        relayGetToken.accept(stringURL)
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let httpResponse = navigationResponse.response as? HTTPURLResponse else {
            decisionHandler(.allow)
            return
        }

        switch httpResponse.statusCode {
        case 400:
            decisionHandler(.cancel)
            relayEndFinish.accept(.failure(ErrorType.Cancel))
        default:
            decisionHandler(.allow)
        }
    }
}
