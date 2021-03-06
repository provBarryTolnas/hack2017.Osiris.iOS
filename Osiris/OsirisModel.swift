//
//  OsirisModel.swift
//  Osiris
//
//  Created by Barry on 8/10/17.
//  Copyright © 2017 Barry. All rights reserved.
//
import Foundation


struct Insurance {
    let name: String
    let isAccepted: Bool
}


struct OsirisModel {
    let numberOfBeds: Int
    let waitTime: Int
    let acceptingNow: Bool
    let insurance: [Insurance]
    let lastUpdated: Date
    
    // The UIDatePicker uses TimeInterval which is measured in seconds while the Osiris DB in Firebase uses integer minutes so we need some conversions both directions.
    var waitTimeSeconds: TimeInterval  {
        get {
           return TimeInterval(waitTime * 60)
        }
    }
    

    
    static func minutes(fromSeconds seconds: TimeInterval) -> Int {
        return Int(round(seconds / 60.0))
    }
    
    static func beds(fromString bedString: String) -> Int? {
        return Int(bedString)
     }
    
    var displayDate:String {
        let dateFormatter = DateFormatter()
        
        let enUSPOSIXLocale: Locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPOSIXLocale
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return "Last Updated: " + dateFormatter.string(from: lastUpdated)
    }
}
