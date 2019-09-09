//
//  DetailRequest.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//

import Foundation

//ENUM FOR FAIL CASES
enum DetailError:Error {
    case errorDataFailure
    case errorCannotProcessData
}


struct DetailRequest {
    
    let requestURL:URL
    
    //CONSTRUCT A DETAIL REQUEST URL GIVEN A USER ID
    init (userID:Int) {
        
        let method:String = "detail/\(String(userID))"
        let requestString = "https://appsheettest1.azurewebsites.net/sample/\(method)"
        guard let requestURL = URL(string: requestString) else { fatalError() }
        self.requestURL = requestURL
    }
    
    //GET USER DETAILS FROM SERVER
    func getDetails (completion: @escaping(Result<DetailInfo, DetailError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            
            guard let jsonData = data else {
                completion (.failure(.errorDataFailure))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let detailInfo = try decoder.decode (DetailInfo.self, from: jsonData)
                completion (.success(detailInfo))
            }
                
            catch{
                completion (.failure(.errorCannotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
}
