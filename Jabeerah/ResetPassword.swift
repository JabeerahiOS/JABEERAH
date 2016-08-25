//
//  ResetPassword.swift
//  Jabeerah
//
//  Created by Ruba O on 11/22/1437 AH.
//  Copyright © 1437 Jabeerah. All rights reserved.
//

import UIKit
import Firebase

class ResetPassword: UIViewController {

    @IBOutlet weak var UserEmail: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    @IBAction func Submit(sender: AnyObject) {
        if self.UserEmail.text == ""
        {
            let alertController = UIAlertController(title: "عفواً", message: "الرجاء ادخال بريدك الالكتروني", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "موافق", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.sendPasswordResetWithEmail(self.UserEmail.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil
                {
                    title = "عفواً!"
                    message = (error?.localizedDescription)!
                }
                else
                {
                    title = "ممتاز!"
                    message = "تم ارسال كلمة المرور"
                    self.UserEmail.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "موافق", style: .Cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
    }
}
