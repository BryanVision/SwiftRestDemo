//
//  ViewController.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//


class DataRequest {
    
    var delegate:UserDetailsViewControllerDelegate?
    var userIDArray: [Int] = []
    var userDetailsArray: [DetailInfo] = []
    
    func request() {
        requestList (tokenString: "")
    }
    
    
    //REQUESTS THE LIST OF USER ID FROM SERVER
    //REPEATS IF RESPONSE INCLUDES A TOKEN
    //MOVES ONTO REQUEST DETAILS IF NO TOKEN
    func requestList (tokenString:String) -> Void {
        
        var listData:ListInfo?
        let listRequest = ListRequest(token: tokenString)
        
        //CREATE A LIST REQUEST
        listRequest.getList { [weak self] result in
            
            switch result {
                
            case .failure(let error):
                print (error)
                
            case .success(let listInfo):
                
                //APPEND ALL USER IDS TO OUR ARRAY
                listData = listInfo
                for element in listData?.result ?? [] {
                    self?.userIDArray.append(element)
                }
                
                //IF TOKEN FOUND, CALL NEXT LIST
                let urlToken:String = listData?.token ?? ""
                if (urlToken != "") {
                    self?.requestList (tokenString: urlToken)
                }
                //IF NO TOKEN, START GETTING USER DETAILS
                else {
                    self?.requestDetails ()
                }
            }
        }
    }
    
    
    //REQUESTS THE USER DETAILS FROM SERVER
    //REPEATS FOR EVERY USER ID IN ARRAY
    //WHEN FINISHED, MOVES ON TO FILTERING
    func requestDetails () -> Void {
        
        if (self.userIDArray.count == 0) {
            return
        }
        
        let userIDValue:Int = self.userIDArray[0]
        
        //CREATE DETAIL REQUEST
        let detailRequest = DetailRequest(userID: userIDValue)
        detailRequest.getDetails { [weak self] result in
            
            switch result {
                
            case .failure(let error):
                print (error)
                print ("------")
                
            //APPEND THE USER DETAILS TO THE ARRAY
            case .success(let detailsInfo):
                let userData:DetailInfo = detailsInfo
                self?.userDetailsArray.append(userData)
                
            }
            
            //REQUEST NEXT USER IN QUEUE
            self?.userIDArray.removeFirst()
            if (self?.userIDArray.count ?? 0 > 0) {
                self?.requestDetails ()
            }
            //IF NO MORE USERS IN QUEUE/ARRAY, MOVE ON TO FILTERING
            else {
                self?.filterUsers ()
            }
        }
    }
    
    //FILTER THE USERS PER THE REQUIREMENTS
    //1 - REMOVE ALL USERS WITH INVALID PHONE NUMBERS
    //2 - SORT USERS BASED ON AGE
    //3 - REMOVE ALL USERS EXCEPT FIVE YOUNGEST
    //4 - SORT USERS BASED ON NAME
    func filterUsers () -> Void {
        
        //FILTER OUT USERS WITH INVALID PHONE NUMBERS
        self.userDetailsArray.removeAll(where: { !$0.number.isPhoneNumber })
        
        //SORT REMAINING USERS BY AGE
        self.userDetailsArray.sort{ $0.age < $1.age }
        
        //REMOVE ALL BUT FIVE YOUNGEST USERS
        self.userDetailsArray.removeSubrange(5 ... (self.userDetailsArray.count - 1))
        
        //SORT REMAINING USERS BY NAME
        self.userDetailsArray.sort{ $0.name < $1.name }
        
        //CALLBACK DELEGATE TO POPULATE TABLEVIEW
        self.delegate?.dataReady(userDetailsArray: self.userDetailsArray)
        
        return
    }
    
    
}
