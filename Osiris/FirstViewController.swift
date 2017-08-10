//
//  FirstViewController.swift
//  Osiris
//
//  Created by Barry on 8/9/17.
//  Copyright © 2017 Barry. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var sendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func availableButtonTapped(_ sender: Any) {
        let updates = ""
        service.sendAvailable()
    }
    
    @IBAction func fullButtonTapped(_ sender: Any) {
        let updates = "Dude!"
        service.sendFull()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

