

import Foundation
import UIKit

class PopOverViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var imagePicker : UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var CategoryPickerView: UIPickerView!
    var Category = ["عكازات", "عربات متحركة", "أدوات دورات المياه", "أجهزة طبية", "أخرى"]

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ImageView: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        CategoryPickerView.delegate = self
        CategoryPickerView.dataSource = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category[row]
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let theInfo:NSDictionary = info as NSDictionary
        let img:UIImage = theInfo.objectForKey(UIImagePickerControllerOriginalImage) as! UIImage
        ImageView.image = img
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func AddPictureBtnAction(sender: UIButton) {
   
        
        
        // addPictureBtnAtion.enabled = false
        let alertController : UIAlertController = UIAlertController(title: "أضف جهازًا", message: "التقط صورة من الكاميرا أو اختر من الألبوم", preferredStyle: .ActionSheet)
        
        let cameraAction : UIAlertAction = UIAlertAction(title: "صورة من الكاميرا", style: .Default, handler: {(cameraAction) in
            print("camera Selected...")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == true {
                
                self.imagePicker.sourceType = .Camera
                self.present()
                
            }else{
                self.presentViewController(self.showAlert("عذرًا", Message: "الكاميرا ليست متاحة في هذا الجهاز أو تم منع الوصول لها!"), animated: true, completion: nil)
                
            }
            
        })
        
        let libraryAction : UIAlertAction = UIAlertAction(title: "صورة من الألبوم", style: .Default, handler: {(libraryAction) in
            
            print("Photo library selected....")
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == true {
                
                self.imagePicker.sourceType = .PhotoLibrary
                self.present()
                
            }else{
                
                self.presentViewController(self.showAlert("عذرًا", Message: "ألبوم الصور ليس متاحًا في هذا الجهاز أو تم منع الوصول له!"), animated: true, completion: nil)
            }
        })
        
        let cancelAction : UIAlertAction = UIAlertAction(title: "إلغاء", style: .Cancel , handler: {(cancelActn) in
            print("Cancel action was pressed")
        })
        
        alertController.addAction(cameraAction)
        
        alertController.addAction(libraryAction)
        
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func present(){
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    /*   func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
     print("info of the pic reached :\(info) ")
     self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
     
     } */
    
    //Show Alert
    func showAlert(Title : String!, Message : String!)  -> UIAlertController {
        
        let alertController : UIAlertController = UIAlertController(title: Title, message: Message, preferredStyle: .Alert)
        let okAction : UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { (alert) in
            print("User pressed ok function")
            
        }
        alertController.addAction(okAction)
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame
        return alertController
    }
    
    
    
    @IBAction func AddDevice(sender: UIButton) {
        
        
        
    }
    
    
}
    