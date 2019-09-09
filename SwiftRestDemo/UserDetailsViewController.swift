//
//  UserDetailsViewController.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//

import UIKit

protocol UserDetailsViewControllerDelegate : class {
    func dataReady(userDetailsArray: [DetailInfo])
}

class UserDetailsViewController: UIViewController, UserDetailsViewControllerDelegate {
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let dataRequest: DataRequest = DataRequest() //Grabs Data
    var dataArray:[DetailInfo] = []              //Stores Data
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //ENABLE CALLBACKS
        tableView.delegate = self
        tableView.dataSource = self
        
        //SETUP INITIAL UI STATE FOR REQUEST
        tableView.isHidden = true
        loadingLabel.isHidden = false
        loadingLabel.text = "Requesting Data..."
        
        //REQUEST DATA FROM SERVER (ASYNCHRONOUS)
        self.dataRequest.delegate = self
        self.dataRequest.request()
        
    }
    
    //CALLBACK - FROM PROTOCALL - WHEN DATA IS LOADED
    func dataReady(userDetailsArray: [DetailInfo]) {
        
        self.dataArray = userDetailsArray
        //printUserDetails ()
        
        //UPDATE THE TABLE VIEW ON THE MAIN THREAD TO ACCOUNT FOR THE NEW DATA
        DispatchQueue.main.async { [weak self] in
            
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
            self?.loadingLabel.isHidden = true
            
        }
        
        return
    }
    
    //CONSOLE BASED PRINT OPTION FOR DEBUGGING
    func printUserDetails () -> Void {
        
        //IF ARRAY IS EMPTY WE CAN'T PRINT ANYTHING
        if (self.dataArray.count == 0) {
            return
        }
        
        //PRINT USERS TO CONSOLE
        for userData in self.dataArray {
            print (userData.id)
            print (userData.name)
            print (userData.age)
            print (userData.number)
            print (userData.photo)
            print (userData.bio)
            print ("------")
        }
    }
    
}

// TABLE VIEW FUNCTIONS
extension UserDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userDetailCell", for: indexPath) as! UserDetailCell
        let userDetails:DetailInfo = self.dataArray[indexPath.row]
        cell.setUserDetails(userDetails: userDetails)
        
        return cell
    }
    
}
