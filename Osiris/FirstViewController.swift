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

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var model: OsirisModel? = nil
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var availabilityView: UIView!
    @IBOutlet weak var insuranceView: UIView!
    @IBOutlet weak var insuranceCollectionView: UICollectionView!
   
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var waitTimePicker: UIDatePicker!
    @IBOutlet weak var numberOfBedsLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [headerView,
         availabilityView,
         insuranceView].forEach { view in
                applyShadow(view)
        }

        waitTimePicker.layer.borderColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        waitTimePicker.layer.borderWidth = 1
        
        insuranceCollectionView.register(UINib(nibName:"InsuranceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InsuranceCell")
        
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
        self.lastUpdatedLabel.text = model.displayDate
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
        if let cell = cell as? InsuranceCollectionViewCell,
            let model = model {
            let insurance = model.insurance[indexPath.item]
            cell.insuranceName = insurance.name
            cell.isAccepted = insurance.isAccepted
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

