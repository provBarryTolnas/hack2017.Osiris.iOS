//
//  FirstViewController.swift
//  Osiris
//
//  Created by Barry on 8/9/17.
//  Copyright © 2017 Barry. All rights reserved.
//

import UIKit

func applyShadow(_ view: UIView) {
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.12
    view.layer.masksToBounds = false
    
}

class FirstViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var availabilityView: UIView!
    @IBOutlet weak var insuranceView: UIView!
   
    @IBOutlet weak var waitTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [headerView, availabilityView, insuranceView].forEach { view in
                applyShadow(view)
        }

        
        service.onUpdate = { [weak self] model in
            print("Refresh FirstViewController")
        }
    }
    
    @IBAction func availableButtonTapped(_ sender: Any) {
        service.sendIsAccepting(isAccepting: true)
    }
    
    @IBAction func fullButtonTapped(_ sender: Any) {
        service.sendIsAccepting(isAccepting: false)
    }
    
    @IBAction func waitTimeChanged(_ sender: UISlider) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

