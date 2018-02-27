//
//  AppLoader.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 07/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
import KRProgressHUD
import KRActivityIndicatorView
class AppLoader {
    var app = AppColor()
    func show (){
        let headColor = app.hexStringToUIColor(hex: "0090CF")
        let tailColor = UIColor.red
        KRProgressHUD.show()
        KRProgressHUD.set(activityIndicatorViewStyle: .gradationColor(head: headColor, tail: tailColor))
        print("show() completion handler.")
    }
    func dismiss (){
        let delay = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: delay) {
            KRProgressHUD.dismiss {
                print("dismiss() completion handler.")
            }
        }
//        KRProgressHUD.dismiss()
//        print("dismiss() completion handler.")
    }
    
    
}
