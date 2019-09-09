//
//  String+isPhoneNumber.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//

import Foundation

extension String {
    
    var isPhoneNumber: Bool {
        
        if (self.count < 10) {
            return false
        }
        
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        }
        catch {
            return false
        }
    }
}

