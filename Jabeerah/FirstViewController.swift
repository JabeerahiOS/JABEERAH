

import UIKit

class FirstViewController: UIViewController {

  
    @IBAction func EmailUrl(sender: AnyObject) {
        let email = "support@jabeerah.com"
        let mailurl = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(mailurl!)

    }
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

