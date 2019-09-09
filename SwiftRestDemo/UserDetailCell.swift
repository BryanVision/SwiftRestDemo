//
//  UserDetailCell.swift
//  SwiftRestApiDemo
//
//  Created by Bryan Mitchell on 9/8/19.
//  Copyright © 2019 Bryan Mitchell. All rights reserved.
//

import UIKit

class UserDetailCell: UITableViewCell {
    
    //CUSTOM TABLE VIEW CELL HAS 5 PARTS, ONE IMAGE FOR USER PHOTO, 4 LABELS (BIO IS NOT CURRENTLY DISPLAYED)
    @IBOutlet weak var UserImageView: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserAgeLabel: UILabel!
    @IBOutlet weak var UserPhoneNumberLabel: UILabel!
    @IBOutlet weak var UserIDLabel: UILabel!
    
    //UPDATE THE CELL (CALLED ON CREATION)
    func setUserDetails (userDetails:DetailInfo)
    {
        UserNameLabel.text = userDetails.name.capitalizingFirstLetter()
        UserAgeLabel.text = "(" + String(userDetails.age) + ")"
        UserIDLabel.text = "ID: [" + String(userDetails.id) + "]"
        UserPhoneNumberLabel.text = userDetails.number
        
        downloadAndSetPhoto (userPhotoString: userDetails.photo)
    }
    
    //ASYNC DOWNLOAD THE PHOTO
    func downloadAndSetPhoto (userPhotoString:String)
    {
        let userImageURL:URL = URL(string: userPhotoString)!
        
        let downloadPicTask = URLSession.shared.dataTask(with: userImageURL) { (data, response, error) in
            
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded Code:\(res.statusCode)")
                    if let imageData = data {
                        
                        let image = UIImage(data: imageData)
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.UserImageView.image = image
                        }
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
        
    }
}
