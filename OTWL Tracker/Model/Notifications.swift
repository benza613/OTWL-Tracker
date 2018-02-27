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
    @objc dynamic var body:String = ""
    @objc dynamic var title:String = ""
    
//    @objc dynamic var sound:String = ""
    @objc dynamic var notificationTime:String = ""
    convenience init(body:String,title:String,notificationTime:String) {
        self.init()
        self.body = body
        self.title = title
        self.notificationTime = notificationTime
    }
}
