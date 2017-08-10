//
//  FirstViewController.swift
//  Osiris
//
//  Created by Barry on 8/9/17.
//  Copyright © 2017 Barry. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func availableButtonTapped(_ sender: Any) {
        service.sendAvailable()
    }
    
    @IBAction func fullButtonTapped(_ sender: Any) {
        service.sendFull()
    }
    
    @IBAction func waitTimeChanged(_ sender: UISlider) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

