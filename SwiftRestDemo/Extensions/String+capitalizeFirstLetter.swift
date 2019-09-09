//
//  String+capitalizeFirstLetter.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
}

