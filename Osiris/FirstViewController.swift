//
//  FirstViewController.swift
//  Osiris
//
//  Created by Barry on 8/9/17.
//  Copyright © 2017 Barry. All rights reserved.
//

import UIKit

fileprivate let acceptingInsuranceColor = UIColor(red: 86.0/255, green: 161.0/255, blue: 213.0/255, alpha: 1)
fileprivate let notAcceptingInsuranceColor = UIColor(white: 0.88, alpha: 1.0)

func applyShadow(_ view: UIView) {
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.12
    view.layer.masksToBounds = false
    
}

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var model: OsirisModel? = nil
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var availabilityView: UIView!
    @IBOutlet weak var insuranceView: UIView!
    @IBOutlet weak var insuranceCollectionView: UICollectionView!
   
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var waitTimePicker: UIDatePicker!
    @IBOutlet weak var numberOfBedsLabel: UILabel!
    
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
            self?.model = model
            DispatchQueue.main.async {
                self?.refreshUI(model)
            }
        }
    }
    
    func refreshUI(_ model: OsirisModel) {
        print("refresh")
        self.availableSwitch.isOn = model.acceptingNow
        self.waitTimePicker.countDownDuration = model.waitTimeSeconds
        self.numberOfBedsLabel.text = String(model.numberOfBeds)
        self.insuranceCollectionView.reloadData()
    }
    
    @IBAction func availableSwitchChanged() {
        service.send(isAccepting: availableSwitch.isOn)
    }
    
    @IBAction func incrementNumberOfBeds() {
        service.incrementNumberOfBeds()
    }
    
    @IBAction func decrementNumberOfBeds() {
        service.decrementNumberOfBeds()
    }
    
    @IBAction func waitTimeChanged(_ waitPicker: UIDatePicker) {
        let time = OsirisModel.minutes(fromSeconds: waitPicker.countDownDuration)
       
        service.send(waitTime: time)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.model {
            return model.insurance.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InsuranceCell", for: indexPath)
        if let label = cell.viewWithTag(999) as? UILabel,
           let model = self.model {
            let insurance = model.insurance[indexPath.item]
            label.text = insurance.name
            cell.backgroundColor = insurance.isAccepted ? acceptingInsuranceColor : notAcceptingInsuranceColor
            
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = self.model  else {
            return
        }
        let insurance = model.insurance[indexPath.item]
        print("didSelect: \(insurance)")
        
        service.toggleInsuranceAccepted(name: insurance.name)
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

