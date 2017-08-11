//
//  InsuranceCollectionViewCell.swift
//  Osiris
//
//  Created by Barry on 8/11/17.
//  Copyright © 2017 Barry. All rights reserved.
//

import UIKit


fileprivate let acceptingInsuranceColor = UIColor(red: 86.0/255, green: 161.0/255, blue: 213.0/255, alpha: 1)
fileprivate let notAcceptingInsuranceColor = UIColor(white: 0.88, alpha: 1.0)


class InsuranceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var insuranceNameLabel: UILabel!
    @IBOutlet weak var checkMarkView: UIImageView!

    var insuranceName: String {
        didSet {
            insuranceNameLabel.text = insuranceName
        }
    }
    var isAccepted: Bool {
        didSet {
            checkMarkView.isHidden = !isAccepted
            backgroundColor = isAccepted ? acceptingInsuranceColor : notAcceptingInsuranceColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        isAccepted = false
        insuranceName = ""
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
