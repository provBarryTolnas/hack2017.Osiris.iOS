//
//  FirstViewController.swift
//  Osiris
//
//  Created by Barry on 8/9/17.
//  Copyright © 2017 Barry. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
   
    @IBOutlet weak var waitTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.title = "Psych Hospital"
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

