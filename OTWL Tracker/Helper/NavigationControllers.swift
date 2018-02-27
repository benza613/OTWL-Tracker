//
//  NavigationControllers.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 12/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
import UIKit
class NavigationControllers {
    
    func navigateTabbar() {
        // switch root view controllers
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "Tabbar")
        appDelegate.window?.rootViewController = nav

    }
    func navigateSignIn() {
        // switch root view controllers
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "SignIn")
        appDelegate.window?.rootViewController = nav
        
    }
    func navigateSignUp() {
        // switch root view controllers
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "Tabbar")
        appDelegate.window?.rootViewController = nav
        
    }
    
    
}
