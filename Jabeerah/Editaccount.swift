//
//  Editaccount.swift
//  Jabeerah
//
//  Created by albendari fawaz on 8/21/16.
//  Copyright © 2016 Jabeerah. All rights reserved.
//

import UIKit
import Firebase

struct postStruct {
    let name : String!
    let email : String!
    let phone : String!
    let city : String!
}

class Editaccount: UIViewController {
    

    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var CityTF: UITextField!
    
    
    let ref = FIRDatabase.database().reference()
    
    var posts = [postStruct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      let ref = FIRDatabase.database().reference()
        ref.child("posts").queryOrderedByKey().observeEventType(.ChildAdded, withBlock:{
            snapshot in
            
            let name = snapshot.value!["name"] as! String
            let email = snapshot.value!["email"] as! String
            let phone = snapshot.value!["phone"] as! String
            let city = snapshot.value!["city"] as! String
            
            self.posts.insert(postStruct(name: name, email: email, phone: phone, city: city) , atIndex: 0)
            
            self.NameTF.text = name
            self.EmailTF.text = email
            self.PhoneTF.text = phone
            self.CityTF.text = city

            
        } )
      // post()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func DoneAction(sender: AnyObject) {
        
   
        guard (FIRAuth.auth()?.currentUser) != nil else { return }
        
       
            guard let Name = NameTF.text where !Name.isEmpty else {
            print("أدخل الأسم من فضلك ")
            return
        }
        
        guard let Phone = PhoneTF.text where !Phone.isEmpty else {
            print("أدخل رقم الجوال من فضلك")
            return
        }

        
        guard let City = CityTF.text where !City.isEmpty else {
            print("أدخل مدينتك من فضلك")
            return
        }

        
        guard let Email = EmailTF.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) where !Email.isEmpty else {
            print("أدخل الإيميل من فضلك ")
            return
        }
        
    
        

        UpdateEmail(Email)  // call
    
        

        
        let user = FIRAuth.auth()?.currentUser
        
      let key = self.ref.child("UserProfile").childByAutoId().key
       let post = ["name": Name,
                   "email" :Email,
                   "phone": Phone,
                   "city": City]
        
     let childUpdates = ["/posts/\(key)": post, "/user-posts/\(user)/\(key)/": post]
     self.ref.updateChildValues(childUpdates)
        
        
       
 }

   
   
    @IBAction func DeleteAction(sender: AnyObject) {
       
        let user = FIRAuth.auth()?.currentUser
    
    
       user?.deleteWithCompletion { error in
             if let error = error {
    // An error happened.
                self.showAlert("خطأ", message: error.localizedDescription)
                
            } else {
    // Account deleted.
              self.showAlert("Succeed", message: "تم حذف الحساب بنجاح")
           }
       }
    
    
    }



    func UpdateEmail(email:String) -> String
    {
        let user = FIRAuth.auth()?.currentUser
        
        user!.updateEmail(email, completion: { (error) in
            if let error = error {
                // An error happened.
                print (error.localizedDescription)
            } else {
                // Email updated.
                self.showAlert("Succeed", message: "تم تحديث الإيميل بنجاح")
            }
        })
        return email
    }
    
    
    
    
    @IBAction func ResetPassword(sender: UIButton) {
        
        
        guard (FIRAuth.auth()?.currentUser) != nil else { return }
        
        
        let alert = UIAlertController(title: "أدخل", message: "كلمة المرورالجديدة", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (tf: UITextField) in
            tf.placeholder = "كلمة المرور"
        }
        
        alert.addTextFieldWithConfigurationHandler { (tf:UITextField) in
            tf.placeholder = "إعادة كلمة المرور"
        }
        alert.addAction(UIAlertAction(title: "ألغاء", style: .Cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "تحديث", style: .Default, handler: { (action:UIAlertAction) in
            if let textFields = alert.textFields {
                let NewPassword = textFields.first!.text!
                let RePassword = textFields[1].text!
                
                
                if NewPassword == "" || RePassword == ""
                {
                    self.showAlert("عذراً", message: " فضلاً أدخل قيمة في الحقل المطلوب")
                    
                }
                else
                    
                {
                    if  NewPassword != RePassword {
                        
                        self.showAlert("عذراً", message: "كلمتا المرور غير متطابقتين")
                            
                    }
                             else
                            {
                                
                                let user = FIRAuth.auth()?.currentUser
                                
                                user?.updatePassword(RePassword, completion:{ error in
                                    if let error = error {
                                        
                                        print (error.localizedDescription)
                                    } else {
                                        // Email updated.
                                        self.showAlert("تم", message: " تم ضبط كلمة المرور بنجاح")
                                    }
                                })
                            }
                        }
                    }
                }
            ))

    
    
    self.presentViewController(alert, animated: true, completion: nil)
    
}



}

