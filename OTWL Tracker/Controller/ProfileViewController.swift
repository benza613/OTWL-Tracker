//
//  ProfileViewController.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 06/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
import RealmSwift
struct UserDetails:Decodable{
//    let EmailID:String
//    let LastName:String
//    let firstName:String
//    let CountryCode:String
//    let MobileNumber:String
//    let Password:String
    
    var db_status:Bool
    var db_msg:String
    var db_auth_token:String
    var db_user_name:String = ""
    var db_user_email:String = ""
    var db_usermb_no:String = ""
    var db_usermb_pfx:String = ""
    var db_user_org:String = ""
}
class ProfileViewController: UIViewController,ShowAlertView{
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    
    let loader = AppLoader()
    let app = AppColor()
    var userDefaultDetails = UserDefaultDetails()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.view.backgroundColor = app.hexStringToUIColor(hex: "0D91CE")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userinfoUpdate()
        
//        print("userinfo:\(userinfo)")
        //
    }
    
    func profileUserInfo() -> ProfileModel {
        let realm = try! Realm()
        let scope = realm.objects(ProfileModel.self)
        return scope.first!
    }
    
    func userinfoUpdate(){
        loader.show();
//        let data =  userDefaultDetails.getUserDetails()
        let userinfo = profileUserInfo()
        print("userinfo:\(userinfo)")

//        let jsonData = try? JSONSerialization.data(withJSONObject: userinfo, options: [])
//        let jsonString = String(data: jsonData!, encoding: .utf8)!
//        print(jsonString)
//        let userinfo = profileUserInfo()
//        let decoder = JSONDecoder()
        do {
            
//            let data = jsonString.data(using: .utf8)!
//            let json = try decoder.decode(UserDetails.self, from: data)
            nameLbl.text = "Name : \(userinfo.db_user_name)"
            emailLbl.text = "Email : \(userinfo.db_user_email)"
            passwordLbl.text = "Orgnization : \(userinfo.db_user_org)"
            mobileLbl.text = " Mobile : \(userinfo.db_usermb_no)"
            loader.dismiss()
        }catch{
            print(error.localizedDescription)
            loader.dismiss()
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateButton(_ sender: Any) {
        self.showSuccessAlert(title: "Success", message: "UserInfo Updated")
    }
    @IBAction func logoutButton(_ sender: Any) {
        let navigationController = NavigationControllers()
        let userDefaultDetails = UserDefaultDetails()
        let alertController = UIAlertController(title: "Logout", message:"Are you sure?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
            //            userDefaultDetails.isloggedIn()
            userDefaultDetails.loggedIN(isLoggedIN: false)
            navigationController.navigateSignIn()
        }))
        alertController.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
