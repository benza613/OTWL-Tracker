//
//  UserDefault.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 12/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
import UIKit
let isLogeddIN = "isLoggedIn"
let isLogeddOUT = "isLogeddOUT"
let UserInfo = "userInfo"
let DeviceToken = "deviceToken"
let FirbaseToken = "firbaseToken"

class UserDefaultDetails{
    var userdefault = UserDefaults()
    func  saveUserDetails(dic:[String:String]) {
        userdefault.set(dic, forKey:UserInfo)
        print(dic)
        userdefault.synchronize()
    }
    func loggedIN(isLoggedIN:Bool){
        userdefault.set(isLoggedIN, forKey:isLogeddIN)
        print(isLoggedIN)
        userdefault.synchronize()
    }
    func saveDeviceToken(deviceToken:String) {
        userdefault.set(deviceToken, forKey:DeviceToken)
        print(DeviceToken)
        userdefault.synchronize()
    }
    func saveFirebaseDeToken(deviceToken:String) {
        userdefault.set(deviceToken, forKey:FirbaseToken)
        print(FirbaseToken)
        userdefault.synchronize()
    }
    
    
    func getDeviceToken() ->String{
        let deviceToken = userdefault.value(forKey:DeviceToken)
        if deviceToken != nil{
            return deviceToken as! String
        }else{
            return ""
        }
    }
    func getFirebaseToken() ->String{
        let deviceToken = userdefault.value(forKey:FirbaseToken)
        if deviceToken != nil{
            return deviceToken as! String
        }else{
            return ""
        }
    }
    
    
//    func loggedOUT(){
//        userdefault.set(false, forKey:isLogeddOUT)
//        userdefault.synchronize()
//    }
//
    func isloggedIn() ->Bool{
        let isloggedIn = userdefault.bool(forKey: isLogeddIN)
        return isloggedIn
        
    }
//    func isloggedOut() ->Bool{
//        let isloggedOut = userdefault.value(forKey:isLogeddOUT)
//        return (isloggedOut != nil)
//    }
    
    func getUserDetails() ->[String:String]{
        let userInfo = userdefault.value(forKey:UserInfo)
        if userInfo != nil{
            return userInfo as! [String : String]

        }else{
            return [:]
        }
    }
}
