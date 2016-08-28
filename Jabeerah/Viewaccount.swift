//
//  Viewaccount.swift
//  Jabeerah
//
//  Created by sharefah rashid on 8/27/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//
import UIKit
import Firebase

struct post {
    let name : String!
    let email : String!
    let phone : String!
    let city : String!
}

class Viewaccount: UIViewController {
    
    

    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var emailTF: UILabel!
    @IBOutlet weak var phoneTF: UILabel!
    @IBOutlet weak var cityTF: UILabel!
    var posts = [post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FIRDatabase.database().reference()
        ref.child("posts").queryOrderedByKey().observeEventType(.ChildAdded, withBlock:{
            snapshot in
            
            let name = snapshot.value!["name"] as! String
            let email = snapshot.value!["email"] as! String
            let phone = snapshot.value!["phone"] as! String
            let city = snapshot.value!["city"] as! String
            
            self.posts.insert(post(name: name, email: email, phone: phone, city: city) , atIndex: 0)
            
            self.nameTF.text = name
            self.emailTF.text = email
            self.phoneTF.text = phone
            self.cityTF.text = city
            
            
        } )
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        
        if FIRAuth.auth()?.currentUser != nil {
            do {
        
        try! FIRAuth.auth()!.signOut()
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     private func loadUserData() {
     
     if let user = FIRAuth.auth()?.currentUser {
     
     if let name = user.displayName {
     self.nameTF.text = name
     }
     if let email = user.email {
     self.emailTF.text = email
     }
     }
     }*/
    
    
    
}