//
//  ListRequest.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//

import Foundation

//ENUM FOR FAIL CASES
enum ListError:Error {
    case errorDataFailure
    case errorCannotProcessData
}


struct ListRequest {
    
    let requestURL:URL
    
    //CONSTRUCT A LIST REQUEST URL GIVEN A TOKEN
    //NOTE: TOKEN="" PRODUCES THE SAME RESULT AS PASSING NO PARAMETER
    init (token:String) {
        
        let method:String = "list?token=\(token)"
        
        let requestString = "https://appsheettest1.azurewebsites.net/sample/\(method)"
        guard let requestURL = URL(string: requestString) else { fatalError() }
        self.requestURL = requestURL
    }
    
    //GET LIST OF USER IDS FROM SERVER
    func getList (completion: @escaping(Result<ListInfo, ListError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            
            guard let jsonData = data else {
                completion (.failure(.errorDataFailure))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let listInfo = try decoder.decode (ListInfo.self, from: jsonData)
                completion (.success(listInfo))
            }
                
            catch{
                completion (.failure(.errorCannotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
}
