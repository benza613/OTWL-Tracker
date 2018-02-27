//
//  ProfileModel.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 26/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
import RealmSwift
class ProfileModel:Object{
    @objc dynamic var db_user_name:String = ""
    @objc dynamic var db_user_email:String = ""
    @objc dynamic var db_usermb_no:String = ""
    @objc dynamic var db_usermb_pfx:String = ""
    @objc dynamic var db_user_org:String = ""
    @objc dynamic var db_auth_token:String = ""
    convenience init(db_user_name:String,db_user_email:String,db_usermb_no:String,db_usermb_pfx:String,db_user_org:String,db_auth_token:String) {
        self.init()
        self.db_user_email = db_user_email
        self.db_user_name  = db_user_name
        self.db_usermb_no = db_usermb_no
        self.db_user_org = db_user_org
        self.db_usermb_pfx = db_usermb_pfx
        self.db_auth_token = db_auth_token
        
    }
    
}
