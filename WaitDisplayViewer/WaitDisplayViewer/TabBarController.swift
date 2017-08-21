//
//  TabViewController.swift
//  WaitDisplayViewer
//
//  Created by Barry on 8/16/17.
//  Copyright © 2017 Providence. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    

    override func viewDidLoad() {
        if let dental = storyboard?.instantiateViewController(withIdentifier: "dental"),
            let urgent = storyboard?.instantiateViewController(withIdentifier: "urgent-care") {
            viewControllers = [urgent,dental]
            self.tabBar.isHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = isLandscape(size) ? "landscape" : "portrait"
        print(orientation)
    }
    

    private func isLandscape(_ size: CGSize) -> Bool {
        return size.width > size.height
    }
    
    override open var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .landscape
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get {
            return .landscapeRight
        }
    }
}
