//
//  ViewController.swift
//  messagingapp
//
//  Created by Haruna Yamakawa on 8/25/20.
//  Copyright © 2020 Haruna. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 

    @IBOutlet weak var tableView: UITableView!
    
    var ref : DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var postData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        // set the firebase reference
        ref = Database.database().reference()
        
        // retrieve the posts and listen for changes
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            // code to execute when a child is added under "Posts"
            // Take the value from the snapshot and added it to  the postData array
            
            // convert the value of the data to string
            let post = snapshot.value as? String
            
            if let actualPost = post {
                // append the data to postData array
                self.postData.append(actualPost)
                // refresh table view
                self.tableView.reloadData()
            
            }
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")!
        cell.textLabel?.text = postData[indexPath.row]
        return cell
        
     }
     
    
    
    


}

