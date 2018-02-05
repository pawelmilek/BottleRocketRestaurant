//
//  InternetViewController.swift
//  BottleRocketRestaurant
//
//  Created by Pawel Milek
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class InternetViewController: UIViewController {
    private lazy var webNavigationView: WebNavigationView = {
        let controller = WebNavigationView(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        controller.delegate = self
        return controller
    }()
    
    private lazy var webView: UIWebView = {
        var webView = UIWebView(frame: .zero)
        webView.delegate = self
        return webView
    }()
    
    private var bottleRocketStudiosURL: URL? {
        let bottleRocketStudiosURLString = "http://www.bottlerocketstudios.com"
        return URL(string: bottleRocketStudiosURLString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRequest()
    }
}


// MARK: - ViewSetupable protocol
extension InternetViewController: ViewSetupable {
    
    func setup() {
        setWebView()
        setWebNavigationButtons()
    }
    
}


// MARK: - Private - Create webView
private extension InternetViewController {
    
    func setWebView() {
        view.addSubview(webView)
        webView.constrainEdges(toMarginOf: view)
    }

}


// MARK: - Private - Load web request
private extension InternetViewController {

    func loadRequest() {
        guard let url = bottleRocketStudiosURL else {
            Logger.log(message: "Unable to load web request", event: .error)
            return
        }
        
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
    
}


// MARK: - Private - Set webNavigationView
private extension InternetViewController {
    
    func setWebNavigationButtons() {
        let webNavigationButtons = UIBarButtonItem(customView: webNavigationView)
        navigationController?.navigationBar.topItem?.leftBarButtonItem = webNavigationButtons
        navigationController?.navigationBar.isTranslucent = false
    }
    
}


// MARK: - UIWebViewDelegate protocol
extension InternetViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        let message = "Webview failed to load.\n \(error)"
        AlertViewPresenter.shared.presentError(withMessage: message)
        ActivityIndicator.shared.stopAnimating()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        ActivityIndicator.shared.startAnimating(at: view)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        ActivityIndicator.shared.stopAnimating()
    }
    
}


// MARK: - WebNavigationViewDelegate protocol
extension InternetViewController: WebNavigationViewDelegate {
    
    func webNavigationView(_ webNavigationView: WebNavigationView, didSelectBackButton: UIButton) {
        webView.goBack()
    }
    
    func webNavigationView(_ webNavigationView: WebNavigationView, didSelectRefreshButton: UIButton) {
        webView.reload()
    }
    
    func webNavigationView(_ webNavigationView: WebNavigationView, didSelectForwardButton: UIButton) {
        webView.goForward()
    }
    
}
