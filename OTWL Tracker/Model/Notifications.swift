//
//  Notifications.swift
//  OTWL Tracker
//
//  Created by Sanjay Mali on 23/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
import RealmSwift
class Notifications:Object{
    @objc dynamic var body = ""
    @objc dynamic var title  = ""
    @objc dynamic var notificationTime = ""
    @objc dynamic var nt_job_id:String = ""
    @objc dynamic var nt_flag:String = ""
    
    convenience init(body:String,title:String,notificationTime:String,nt_job_id:String,nt_flag:String) {
        self.init()
        self.body = body
        self.title = title
        self.notificationTime = notificationTime
        self.nt_job_id = nt_job_id
        self.nt_flag = nt_flag
        
    }
}
extension Notifications{
//    func writeNotifications(){
//        
//        do {
//            try appDelrealm.write{
//                appDelrealm.add(self)
//            }            
//        }catch let error {
//            print(error)
//        }
//    }
}

