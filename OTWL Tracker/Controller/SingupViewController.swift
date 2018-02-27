//
//  SingupViewController.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 13/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
struct Signup:Decodable{
    var db_status:Bool
    var db_msg:String
}
class SingupViewController: UIViewController,UITextFieldDelegate,ShowAlertView{
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var companyNameTxt: UITextField!
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var prefixTxt: UITextField!
    let navigationControllers = NavigationControllers()
    let userDefaultDetails = UserDefaultDetails()
    
    @IBOutlet weak var signup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        fullNameTxt.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        mobileTxt.attributedPlaceholder = NSAttributedString(string: "Mobile Number",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        prefixTxt.attributedPlaceholder = NSAttributedString(string: "+91",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        companyNameTxt.attributedPlaceholder = NSAttributedString(string: "Company Name",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.emailTxt.delegate = self
        self.passwordTxt.delegate = self
        self.companyNameTxt.delegate = self
        self.mobileTxt.delegate = self
        self.prefixTxt.delegate = self
        
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        emailTxt.transform = CGAffineTransform(translationX: -256, y: -256)
        passwordTxt.transform = CGAffineTransform(translationX: 256, y: -256)
        mobileTxt.transform = CGAffineTransform(translationX: -256, y: -256)
        prefixTxt.transform = CGAffineTransform(translationX: -256, y: -256)

        fullNameTxt.transform = CGAffineTransform(translationX: 256, y: -256)
        companyNameTxt.transform = CGAffineTransform(translationX: -256, y: -256)
        
        
        //                emailTxt.transform = CGAffineTransform(scaleX: 2, y: 2)
        //                passwordTxt.transform = CGAffineTransform(scaleX: 2, y: 2)
        //                mobileTxt.transform = CGAffineTransform(scaleX: 2, y: 2)
        //                fullNameTxt.transform = CGAffineTransform(scaleX: 2, y: 2)
        //                companyNameTxt.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        
        //        signup.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        signup.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        UIView.animate(withDuration: 0.4) {
            //            self.emailTxt.transform = CGAffineTransform.identity
            //            self.passwordTxt.transform = CGAffineTransform.identity
            self.mobileTxt.transform = CGAffineTransform.identity
            self.prefixTxt.transform = CGAffineTransform.identity

            //            self.fullNameTxt.transform = CGAffineTransform.identity
            //            self.companyNameTxt.transform = CGAffineTransform.identity
            //            self.signup.transform = CGAffineTransform.identity
        }
        
        
        UIView.animate(withDuration: 0.5) {
            self.emailTxt.transform = CGAffineTransform.identity
            
        }
        
        UIView.animate(withDuration: 0.6) {
            self.passwordTxt.transform = CGAffineTransform.identity
            
        }
        
        UIView.animate(withDuration: 0.7) {
            self.companyNameTxt.transform = CGAffineTransform.identity
            
        }
        UIView.animate(withDuration: 0.8) {
            self.fullNameTxt.transform = CGAffineTransform.identity
            
        }
        UIView.animate(withDuration: 0.9) {
            self.signup.transform = CGAffineTransform.identity
            
        }
    }
    @IBAction func signUPButton(_ sender: Any) {
        //        if fnameTxt.text == ""{
        //            self.showAlert(message: "Enter First Name")
        //
        //        }else if lnameTxt.text == ""{
        //            //            print("Enter Last Name")
        //            self.showAlert(message: "Enter Last Name")
        //        }
        if emailTxt.text == "" {
            print("Enter Email")
            self.showAlert(message: "Enter Email ID")
        }
        if !(isValidEmail(testStr: emailTxt.text!)){
            self.showAlert(message: "Enter Enter Valid Emaild ID ")
        }
        else if companyNameTxt.text == "" || mobileTxt.text == ""{
            self.showAlert(message: "Enter Company Name ")
        }
        else if passwordTxt.text == ""{
            print("Enter Password")
            self.showAlert(message: "Enter Password")
        }
            
        else if prefixTxt.text == ""{
            print("Enter Password")
            self.showAlert(message: "Enter Country Code")
        }
        else if mobileTxt.text == ""{
            print("Enter Password")
            self.showAlert(message: "Enter Mobile Number")
        }
        else{
            let dic = ["FullName":"\(self.fullNameTxt.text!)",
                "MobileNumber":"\(self.mobileTxt.text!)",
                "Password":"\(self.passwordTxt.text!)",    "CompanyName":"\(self.companyNameTxt.text!)",
                "EmailID":"\(self.emailTxt.text!)"]
            
            //            self.userDefaultDetails.saveUserDetails(dic:dic)
            let loader = AppLoader()
            loader.show();
            let url = "http://apiocean20180207065702.azurewebsites.net/api/ocean/usr_signup"
            let paramString = "usrr_fnm=\(fullNameTxt.text!)" + "&usrr_mb_no=\(mobileTxt.text!)" + "&usrr_psw=\(passwordTxt.text!)" + "&usrr_eml=\(emailTxt.text!)" +
                "&usrr_mb_pfx=\(prefixTxt.text!)" + "&ussr_org_name=\(companyNameTxt.text!)"
            print(paramString)
            DataManager.getJSONFromURL(url, param:paramString, completion: { (data, error) in                
                let decoder = JSONDecoder()
                do {
                   
                    let json = try decoder.decode(Signup.self, from: data!)
                    print(json)
                    if json.db_status == true{
                        self.userDefaultDetails.loggedIN(isLoggedIN: true)
                        DispatchQueue.main.async {
                            self.navigationControllers.navigateTabbar()
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
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}


