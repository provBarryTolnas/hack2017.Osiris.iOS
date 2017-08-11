//
//  OsirisModel.swift
//  Osiris
//
//  Created by Barry on 8/10/17.
//  Copyright © 2017 Barry. All rights reserved.
//
import Foundation

struct OsirisModel {
    let numberOfBeds: Int
    let waitTime: Int
    let acceptingNow: Bool
    
    var waitTimeSeconds: TimeInterval  {
        get {
           return TimeInterval(waitTime * 60)
        }
    }
    
    static func minutes(fromSeconds seconds: TimeInterval) -> Int {
        return Int(round(seconds / 60.0))
    }
}
