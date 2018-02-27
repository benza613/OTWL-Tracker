//
//  ViewController.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 13/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
import RealmSwift
struct SignIn:Decodable{
    var db_status:Bool
    var db_msg:String
    var db_auth_token:String
    var db_user_name:String = ""
    var db_user_email:String = ""
    var db_usermb_no:String = ""
    var db_usermb_pfx:String = ""
    var db_user_org:String = ""
    
}

class SignInViewController: UIViewController,UITextFieldDelegate,ShowAlertView{
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var signIn: UIButton!
    
    @IBOutlet weak var viewbg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email/Mobile Number",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        self.emailTxt.delegate = self
        self.passwordTxt.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    
    
    @objc  func keyboardWillShow(_ notification:Notification) {
        adjustingHeight(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    func adjustingHeight(_ show:Bool, notification:Notification) {
        
        var userInfo = (notification as NSNotification).userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeInHeight = (keyboardFrame.height ) * (show ? 1 : 0)
        //        self.bottomSpace.constant = changeInHeight
        
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //        emailTxt.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        emailTxt.transform = CGAffineTransform(translationX: -256, y: -256)
        
        //        passwordTxt.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        //        passwordTxt.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        passwordTxt.transform = CGAffineTransform(translationX: 256, y: -256)
        //        signIn.transform = CGAffineTransform(translationX: -256, y: -256)
        //        signIn.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        signIn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        UIView.animate(withDuration: 0.5) {
            self.emailTxt.transform = CGAffineTransform.identity
            //            self.passwordTxt.transform = CGAffineTransform.identity
            //            self.signIn.transform = CGAffineTransform.identity
            
        }
        
        UIView.animate(withDuration: 0.6) {
            self.passwordTxt.transform = CGAffineTransform.identity
            
        }
        UIView.animate(withDuration: 0.8) {
            self.signIn.transform = CGAffineTransform.identity
            
        }
    }
    
    @IBAction func signINButton(_ sender: Any) {
        if emailTxt.text == ""{
            self.showAlert(message: "Enter Enter Valid Emaild ID ")
        }
        else if passwordTxt.text == ""{
            print("Enter Password")
            self.showAlert(message: "Enter Password")
        }
        else{
            let loader = AppLoader()
            loader.show();
            let navigationController = NavigationControllers()
            let url = "http://apiocean20180207065702.azurewebsites.net/api/ocean/usr_signin"
            let userDefaultDetails = UserDefaultDetails()
            let deviceToken = userDefaultDetails.getDeviceToken()
            let firebaseToken = userDefaultDetails.getFirebaseToken()
            
            let paramString = "usrr_sn1=\(emailTxt.text!)" + "&usrr_sn2=\(passwordTxt.text!)" + "&device_token=\(deviceToken)" + "&firebase_token=\(firebaseToken)"
            DataManager.getJSONFromURL(url, param:paramString, completion: { (data, error) in
                let decoder = JSONDecoder()
                do {
                    let json = try decoder.decode(SignIn.self, from: data!)
                    print(json)
                    if json.db_status == true{
                        userDefaultDetails.loggedIN(isLoggedIN: true)
                        self.writeProfileData(json:json)
                        DispatchQueue.main.async {
                            navigationController.navigateTabbar()
                            loader.dismiss()
                        }
                    }else{
                        self.showAlert(message:json.db_msg)
                        loader.dismiss()
                    }
                }catch{
                    print(error.localizedDescription)
                    loader.dismiss()
                }
            })
        }
    }
    func writeProfileData(json:SignIn){
        let userinfo = ProfileModel()
        userinfo.db_user_email = json.db_user_email
        userinfo.db_user_name = json.db_user_name
        userinfo.db_usermb_pfx = json.db_usermb_pfx
        userinfo.db_usermb_no = json.db_usermb_no
        userinfo.db_user_org = json.db_user_org
        userinfo.db_auth_token = json.db_auth_token
        let realm = try! Realm()
        // Persist your data easily
        try! realm.write {
            realm.add(userinfo)
        }
        
    }
}

