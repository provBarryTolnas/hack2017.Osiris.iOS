//
//  ViewController.swift
//  WaitDisplayViewer
//
//  Created by Barry on 8/16/17.
//  Copyright © 2017 Providence. All rights reserved.
//

import UIKit
import WebKit

class WaitDisplayViewController: UIViewController, WKNavigationDelegate, UIGestureRecognizerDelegate {
    @IBInspectable var url: String = ""
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: view.bounds)
        if let webView = webView {
            self.view.addSubview(webView)
            webView.translatesAutoresizingMaskIntoConstraints = false
            webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            webView.navigationDelegate = self
        }
        
        //Install a double-tap recognizer to trigger reload of page
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(WaitDisplayViewController.reload))
        tapRecognizer.numberOfTapsRequired = 2
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    func reload() {
        print("reload")
        webView?.reloadFromOrigin()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let request = URLRequest(url: URL(string: url)!)
        webView?.load(request)
    }
    
    //MARK: UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: UIWebViewDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finished loading \(webView.url!)")
        print("content: \(webView)")
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
//            let offsetY = max(0.0, webView.scrollView.contentSize.height - webView.bounds.size.height)
//            let offset = CGPoint(x: 0, y: offsetY )
//            webView.scrollView.setContentOffset(offset, animated: true)
//        }
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
}

