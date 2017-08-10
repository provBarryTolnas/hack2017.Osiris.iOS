//
//  OsirisService.swift
//  Osiris
//
//  Created by Barry on 8/9/17.
//  Copyright © 2017 Barry. All rights reserved.
//

import Foundation
import Alamofire


fileprivate let localURL = "http://localhost:8080/send"
fileprivate let osirisURL = "https://osiris-26b00.firebaseio.com/providers/examplenew123.json"

let service = OsirisService()

class  OsirisService {
    func sendAvailable() {
        send("true")
    }
    
    func sendFull() {
        send("false")
    }
    
    /*************
    {
    "acceptingNow": true,
    "bedsOpen": 1,
    "updateDateTime": {".sv": "timestamp"}
    }
    **************/
    
    private func send(_ availability: String) {
        print("Send Availability \(availability)")
        let parameters: [String:Any] = [ "Available" : availability ]
        Alamofire.request(osirisURL, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: [:])
        .responseJSON { (resp) in
            print("Server response: \(resp)")
        }
    }
}
