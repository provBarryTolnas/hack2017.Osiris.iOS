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
   
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var waitTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [headerView,
         availabilityView,
         insuranceView].forEach { view in
                applyShadow(view)
        }

        waitTimePicker.layer.borderColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        waitTimePicker.layer.borderWidth = 1
        
        service.onUpdate = { [weak self] model in
            print("refresh")
            self?.availableSwitch.isOn = model.acceptingNow
            self?.waitTimePicker.countDownDuration = model.waitTimeSeconds
        }
    }
    
    @IBAction func availableSwitchChanged(_ theSwitch: UISwitch) {
        service.send(isAccepting: theSwitch.isOn)
    }
    
    @IBAction func waitTimeChanged(_ waitPicker: UIDatePicker) {
        let time = OsirisModel.minutes(fromSeconds: waitPicker.countDownDuration)
       
        service.send(waitTime: time)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

