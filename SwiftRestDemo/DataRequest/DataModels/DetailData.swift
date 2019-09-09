//
//  DetailData.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//

import Foundation

/*  DATA MODEL FOR JSON RESULT FROM
 appsheettest1.azurewebsites.net/sample/detail/(USERNUM)
 
 {
     "id": 21,
     "name": "paul",
     "age": 48,
     "number": "555-555-5555",
     "photo": "https://appsheettest1.azurewebsites.net/male-11.jpg",
     "bio": "Lorem ipsum dolor sit amet, consectetur adipiscing elit..."
 }
 
 id is (INT)
 name is (STRING)
 age is (INT)
 number is (STRING)
 photo is (STRING)
 bio is (STRING)
 
 */

struct DetailInfo:Decodable {
    
    var id:Int
    var name:String
    var age:Int
    var number:String
    var photo:String
    var bio:String
    
}

