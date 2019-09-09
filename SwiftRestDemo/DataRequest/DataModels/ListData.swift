//
//  ListData.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//

import Foundation

/*  DATA MODEL FOR JSON RESULT FROM
 appsheettest1.azurewebsites.net/sample/list
 
 {
     "result": [
         1,
         2,
         3,
         4,
         5,
         6,
         7,
         8,
         9,
         10
     ],
     "token": "a35b4"
 }
 
 "result" is array (INT)
 "token" is optional (STRING)
 */


struct ListInfo:Decodable {
    
    var result:[Int]
    var token:String?
    
    init (result:[Int]){
        self.result = result
    }
    
}
